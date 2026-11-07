import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dominio/ritmo.dart';
import '../tema/estilo_cifra.dart';
import '../tema/estilo_error.dart';

/// Campo de ritmo compartido (perfil, entrenamiento y filtro): la cifra grande
/// con − / +, de segundo en segundo, entre [minimo] y [maximo]. Al tocar la
/// cifra se escribe el ritmo exacto con el teclado de números. No guarda nada:
/// muestra [valor] y avisa con [alCambiar].
class CampoRitmo extends StatefulWidget {
  const CampoRitmo({super.key, required this.valor, required this.alCambiar});

  /// Ritmo que se muestra; `null` es "sin ritmo".
  final Ritmo? valor;

  final ValueChanged<Ritmo> alCambiar;

  /// Desde donde parte el primer − / + cuando no hay ritmo.
  static final Ritmo inicial = Ritmo.parse('5:00.0');

  /// Ritmo más rápido que acepta el campo.
  static final Ritmo minimo = Ritmo.parse('2:30.0');

  /// Ritmo más lento que acepta el campo.
  static final Ritmo maximo = Ritmo.parse('10:00.0');

  @override
  State<CampoRitmo> createState() => _CampoRitmoState();
}

class _CampoRitmoState extends State<CampoRitmo> {
  static const String _vacio = '–:––.–';

  /// "Entre 2:30 y 10:00 /km": los límites sin décima.
  static final String _fueraDeRango =
      'Entre ${_sinDecima(CampoRitmo.minimo)} y '
      '${_sinDecima(CampoRitmo.maximo)} /km';

  /// "M:SS": 2:30.0 → "2:30".
  static String _sinDecima(Ritmo ritmo) =>
      '${ritmo.minutos}:${ritmo.segundosDelMinuto.toString().padLeft(2, '0')}';

  final _texto = TextEditingController();
  final _foco = FocusNode();
  bool _escribiendo = false;

  /// Por qué no sirvió lo último que se escribió.
  String? _error;

  @override
  void initState() {
    super.initState();
    // Salir del campo también confirma.
    _foco.addListener(() {
      if (!_foco.hasFocus) _confirmar();
    });
  }

  @override
  void dispose() {
    _texto.dispose();
    _foco.dispose();
    super.dispose();
  }

  /// − / +: un cambio válido, así que también borra el aviso anterior.
  void _mover(int segundos) {
    setState(() => _error = null);
    final actual = widget.valor;
    if (actual == null) return widget.alCambiar(CampoRitmo.inicial);
    widget.alCambiar(_dentroDelRango(actual.sumarSegundos(segundos)));
  }

  /// [ritmo], o el límite más cercano si queda fuera de
  /// [CampoRitmo.minimo]–[CampoRitmo.maximo].
  static Ritmo _dentroDelRango(Ritmo ritmo) {
    if (ritmo < CampoRitmo.minimo) return CampoRitmo.minimo;
    if (ritmo > CampoRitmo.maximo) return CampoRitmo.maximo;
    return ritmo;
  }

  void _empezarAEscribir() {
    _texto.clear();
    setState(() {
      _escribiendo = true;
      _error = null;
    });
  }

  /// Revisa lo escrito: si sirve lo entrega; si no, avisa debajo y la cifra
  /// vuelve a [CampoRitmo.valor]. Sin nada escrito también avisa el formato.
  void _confirmar() {
    if (!_escribiendo) return;
    final ritmo = Ritmo.tryParse(_texto.text);
    final error = ritmo == null
        ? 'Escribe el ritmo como 4:05.3'
        : ritmo < CampoRitmo.minimo || ritmo > CampoRitmo.maximo
        ? _fueraDeRango
        : null;
    setState(() {
      _escribiendo = false;
      _error = error;
    });
    if (error == null) widget.alCambiar(ritmo!);
  }

  @override
  Widget build(BuildContext context) {
    final valor = widget.valor;
    final error = _error;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _cifra(valor),
        if (error != null) Text(error, style: estiloError(context)),
      ],
    );
  }

  /// Lo que anuncia el lector de pantalla por la cifra:
  /// 4:05.3 → "Ritmo, 4 minutos 5,3 segundos por kilómetro".
  static String _enPalabras(Ritmo? valor) {
    if (valor == null) return 'Ritmo, todavía no hay ritmo';
    return 'Ritmo, ${valor.minutos} minutos '
        '${valor.segundosDelMinuto},${valor.decimaDelSegundo} segundos '
        'por kilómetro';
  }

  /// La cifra (o lo que se va escribiendo) con − / + y la unidad.
  Widget _cifra(Ritmo? valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, semanticLabel: 'Más rápido'),
          // Apagado en el mínimo o por debajo: nunca lleva a un ritmo más lento.
          onPressed: valor != null && valor <= CampoRitmo.minimo
              ? null
              : () => _mover(-1),
        ),
        if (_escribiendo)
          IntrinsicWidth(
            child: TextField(
              controller: _texto,
              focusNode: _foco,
              autofocus: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [_AcomodarCifras()],
              style: estiloCifra(),
              decoration: const InputDecoration.collapsed(hintText: _vacio),
              onSubmitted: (_) => _confirmar(),
            ),
          )
        else
          GestureDetector(
            onTap: _empezarAEscribir,
            child: Semantics(
              label: _enPalabras(valor),
              excludeSemantics: true,
              child: Text(valor?.toString() ?? _vacio, style: estiloCifra()),
            ),
          ),
        const SizedBox(width: 8),
        // La unidad ya va en lo que anuncia la cifra.
        const ExcludeSemantics(child: Text('/km')),
        IconButton(
          icon: const Icon(Icons.add, semanticLabel: 'Más lento'),
          // Apagado en el máximo o por encima: nunca lleva a un ritmo más rápido.
          onPressed: valor != null && valor >= CampoRitmo.maximo
              ? null
              : () => _mover(1),
        ),
      ],
    );
  }
}

/// Acomoda las cifras escritas de derecha a izquierda y arma "M:SS.d": la
/// última es la décima, las dos anteriores los segundos y el resto los minutos
/// ("4053" → "4:05.3", "12300" → "12:30.0"). Lo que falta se ve como "–".
class _AcomodarCifras extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue anterior,
    TextEditingValue nuevo,
  ) {
    final cifras = nuevo.text.replaceAll(RegExp(r'\D'), '');
    if (cifras.isEmpty) return TextEditingValue.empty;
    final completas = cifras.padLeft(4, '–');
    final largo = completas.length;
    final minutos = completas.substring(0, largo - 3);
    final segundos = completas.substring(largo - 3, largo - 1);
    final decima = completas[largo - 1];
    final texto = '$minutos:$segundos.$decima';
    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}
