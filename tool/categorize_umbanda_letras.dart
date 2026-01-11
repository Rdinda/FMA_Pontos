import 'dart:convert';
import 'dart:io';

typedef CategoryResult = ({String type, String name});

final _orixaMatchers = <({String name, List<RegExp> matchers})>[
  (name: 'Oxalá', matchers: [RegExp(r'\boxal[áa]\b', caseSensitive: false)]),
  (name: 'Ogum', matchers: [RegExp(r'\bogum\b', caseSensitive: false)]),
  (
    name: 'Oxóssi',
    matchers: [
      RegExp(r'\box[oó]ssi\b', caseSensitive: false),
      RegExp(r'\boxossi\b', caseSensitive: false),
    ],
  ),
  (
    name: 'Xangô',
    matchers: [
      RegExp(r'\bxang[oô]\b', caseSensitive: false),
      RegExp(r'\bka[oô]\b', caseSensitive: false),
    ],
  ),
  (
    name: 'Iemanjá',
    matchers: [
      RegExp(r'\biemanj[aá]\b', caseSensitive: false),
      RegExp(r"\bm[ãa]e d['’]agua\b", caseSensitive: false),
    ],
  ),
  (name: 'Oxum', matchers: [RegExp(r'\boxum\b', caseSensitive: false)]),
  (
    name: 'Iansã',
    matchers: [
      RegExp(r'\bians[aã]\b', caseSensitive: false),
      RegExp(r'\boy[aá]\b', caseSensitive: false),
      RegExp(r'\beparrey\b', caseSensitive: false),
    ],
  ),
  (
    name: 'Omolu',
    matchers: [
      RegExp(r'\bomolu\b', caseSensitive: false),
      RegExp(r'\bobaluai[eê]\b', caseSensitive: false),
      RegExp(r'\bobaluaye\b', caseSensitive: false),
      RegExp(r'\bobo?luay[êe]\b', caseSensitive: false),
    ],
  ),
  (
    name: 'Nanã',
    matchers: [
      RegExp(r'\bnan[aã]\b', caseSensitive: false),
      RegExp(r'\bnan[aã]\s*buroqu[eê]\b', caseSensitive: false),
    ],
  ),
  (
    name: 'Oxumaré',
    matchers: [
      RegExp(r'\boxumar[eé]\b', caseSensitive: false),
      RegExp(r'\boxumare\b', caseSensitive: false),
    ],
  ),
  (
    name: 'Logunedé',
    matchers: [
      RegExp(r'\bloguned[eé]\b', caseSensitive: false),
      RegExp(r'\blogunede\b', caseSensitive: false),
    ],
  ),
  (
    name: 'Ibeji',
    matchers: [
      RegExp(r'\bibeji\b', caseSensitive: false),
      RegExp(r'\bcosme\s+e\s+dami[aã]o\b', caseSensitive: false),
      RegExp(r'\bdois\s+irm[aã]os\b', caseSensitive: false),
    ],
  ),
];

final _knownEntityMatchers =
    <({String name, String type, List<RegExp> matchers})>[
      (
        name: 'Zé Pilintra',
        type: 'guia',
        matchers: [
          RegExp(r'\bz[eé]\s*pilintra\b', caseSensitive: false),
          RegExp(r'\bseu\s*z[eé]\s*pilintra\b', caseSensitive: false),
        ],
      ),
      (
        name: 'Tranca Ruas',
        type: 'entidade',
        matchers: [
          RegExp(r'\btranca\s*ruas\b', caseSensitive: false),
          RegExp(r'\btranca\s*rua\b', caseSensitive: false),
        ],
      ),
      (
        name: 'Maria Padilha',
        type: 'entidade',
        matchers: [RegExp(r'\bmaria\s+padilha\b', caseSensitive: false)],
      ),
      (
        name: 'Maria Mulambo',
        type: 'entidade',
        matchers: [RegExp(r'\bmaria\s+mulambo\b', caseSensitive: false)],
      ),
      (
        name: 'Rosa Caveira',
        type: 'entidade',
        matchers: [RegExp(r'\brosa\s+caveira\b', caseSensitive: false)],
      ),
      (
        name: 'Sete Saias',
        type: 'entidade',
        matchers: [
          RegExp(r'\bsete\s+saias\b', caseSensitive: false),
          RegExp(r'\b7\s+saias\b', caseSensitive: false),
        ],
      ),
      (
        name: 'Exu Caveira',
        type: 'entidade',
        matchers: [RegExp(r'\bexu\s+caveira\b', caseSensitive: false)],
      ),
      (
        name: 'Exu Tiriri',
        type: 'entidade',
        matchers: [RegExp(r'\bexu\s+tiriri\b', caseSensitive: false)],
      ),
      (
        name: 'Exu Marabô',
        type: 'entidade',
        matchers: [
          RegExp(r'\bexu\s+marab[oô]\b', caseSensitive: false),
          RegExp(r'\bmarab[oô]\b', caseSensitive: false),
        ],
      ),
      (
        name: 'Exu Meia-Noite',
        type: 'entidade',
        matchers: [
          RegExp(r'\bexu\s+meia[-\s]?noite\b', caseSensitive: false),
          RegExp(r'\bseu\s+meia[-\s]?noite\b', caseSensitive: false),
        ],
      ),
    ];

String _normalizeSpaces(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

String _normalizeTitleForExtraction(String title) {
  return _normalizeSpaces(
    title
        .replaceAll('–', '-')
        .replaceAll('—', '-')
        .replaceAll(RegExp(r'\s*/\s*'), ' / '),
  );
}

String? _extractFromParen(String title) {
  final matches = RegExp(r'\(([^)]{2,80})\)').allMatches(title).toList();
  if (matches.isEmpty) return null;

  for (final m in matches) {
    final inside = _normalizeSpaces(m.group(1) ?? '');
    final ponto = RegExp(
      r'^(ponto\s+de)\s+(.+)$',
      caseSensitive: false,
    ).firstMatch(inside);
    if (ponto != null) {
      return _normalizeSpaces(ponto.group(2) ?? '');
    }

    if (inside.isNotEmpty) {
      return inside;
    }
  }

  return null;
}

String? _extractAfterKeyword(String title, String keyword) {
  final normalized = _normalizeTitleForExtraction(title);
  final idx = normalized.toLowerCase().indexOf(keyword.toLowerCase());
  if (idx < 0) return null;

  var chunk = normalized.substring(idx);
  final cut = chunk.indexOf('-');
  if (cut >= 0) {
    chunk = chunk.substring(0, cut);
  }

  chunk = chunk.replaceAll(RegExp(r'\(.*?\)'), '');
  chunk = _normalizeSpaces(chunk);
  if (chunk.isEmpty) return null;
  return chunk;
}

final _linhaSecondWordStopwords = <String>{
  'a',
  'o',
  'as',
  'os',
  'um',
  'uma',
  'uns',
  'umas',
  'de',
  'do',
  'da',
  'dos',
  'das',
  'no',
  'na',
  'nos',
  'nas',
  'em',
  'e',
  'é',
  'eh',
  'deu',
  'toque',
  'toca',
  'tocai',
  'vai',
  'vem',
  'chegou',
  'chega',
  'cantou',
  'canta',
  'dançou',
  'dança',
  'só',
  'so',
};

String? _extractSpecificIfStartsWithKeyword(String title, String keyword) {
  final normalized = _normalizeTitleForExtraction(title).trimLeft();
  if (!normalized.toLowerCase().startsWith(keyword.toLowerCase())) return null;
  final extracted = _extractAfterKeyword(normalized, keyword);
  if (extracted == null) return null;

  final parts = extracted.split(' ');
  if (parts.length >= 2) {
    final second = parts[1].toLowerCase();
    if (_linhaSecondWordStopwords.contains(second)) return null;
  }

  return extracted;
}

CategoryResult? _findOrixa(String text) {
  for (final entry in _orixaMatchers) {
    for (final re in entry.matchers) {
      if (re.hasMatch(text)) {
        return (type: 'orixa', name: entry.name);
      }
    }
  }
  return null;
}

CategoryResult? _findKnownEntity(String text) {
  for (final entry in _knownEntityMatchers) {
    for (final re in entry.matchers) {
      if (re.hasMatch(text)) {
        return (type: entry.type, name: entry.name);
      }
    }
  }
  return null;
}

CategoryResult? _extractLinhaPorTitulo(String title) {
  final normalized = _normalizeTitleForExtraction(title);
  final lower = normalized.toLowerCase();

  final fromParen = _extractFromParen(normalized);
  if (fromParen != null && fromParen.isNotEmpty) {
    final orixa = _findOrixa(fromParen);
    if (orixa != null) return orixa;

    final known = _findKnownEntity(fromParen);
    if (known != null) return known;

    if (RegExp(
      r'\b(pomba\s*gira|pombagira|pombo\s*gira)\b',
      caseSensitive: false,
    ).hasMatch(fromParen)) {
      return (type: 'entidade', name: 'Pomba Gira');
    }

    if (RegExp(r'\bexu\b', caseSensitive: false).hasMatch(fromParen)) {
      return (type: 'entidade', name: fromParen);
    }

    return (type: 'entidade', name: fromParen);
  }

  final orixaInTitle = _findOrixa(normalized);
  if (orixaInTitle != null) return orixaInTitle;

  final knownInTitle = _findKnownEntity(normalized);
  if (knownInTitle != null) return knownInTitle;

  if (lower.contains('caboclo') || lower.contains('cabloco')) {
    final extracted =
        _extractAfterKeyword(normalized, 'Caboclo') ??
        _extractAfterKeyword(normalized, 'Cabloco');
    if (extracted != null) return (type: 'guia', name: extracted);
    return (type: 'guia', name: 'Caboclos');
  }

  if (lower.contains('preto velho')) {
    final extracted = _extractAfterKeyword(normalized, 'Preto Velho');
    if (extracted != null) return (type: 'guia', name: extracted);
    return (type: 'guia', name: 'Pretos Velhos');
  }

  if (lower.contains('boiadeiro') || lower.contains('boiadeiros')) {
    final extracted = _extractSpecificIfStartsWithKeyword(
      normalized,
      'Boiadeiro',
    );
    if (extracted != null) return (type: 'guia', name: extracted);
    return (type: 'guia', name: 'Boiadeiros');
  }

  if (lower.contains('baiana') || lower.contains('baiano')) {
    final extracted =
        _extractSpecificIfStartsWithKeyword(normalized, 'Baiana') ??
        _extractSpecificIfStartsWithKeyword(normalized, 'Baiano') ??
        _findKnownEntity(normalized)?.name;
    if (extracted != null) {
      return (type: 'guia', name: extracted);
    }
    return (type: 'guia', name: 'Baianos');
  }

  if (lower.contains('marinheiro') || lower.contains('marinheiros')) {
    final extracted = _extractSpecificIfStartsWithKeyword(
      normalized,
      'Marinheiro',
    );
    if (extracted != null) return (type: 'guia', name: extracted);
    return (type: 'guia', name: 'Marinheiros');
  }

  if (lower.contains('cigano') || lower.contains('ciganos')) {
    final extracted =
        _extractSpecificIfStartsWithKeyword(normalized, 'Cigano') ??
        _extractSpecificIfStartsWithKeyword(normalized, 'Cigana');
    if (extracted != null) return (type: 'guia', name: extracted);
    return (type: 'guia', name: 'Ciganos');
  }

  if (lower.contains('crian') ||
      lower.contains('erê') ||
      lower.contains('ere') ||
      lower.contains('cosme') ||
      lower.contains('dami')) {
    return (type: 'guia', name: 'Crianças');
  }

  if (lower.contains('exu')) {
    final extracted = _extractAfterKeyword(normalized, 'Exu');
    if (extracted != null) return (type: 'entidade', name: extracted);
    return (type: 'entidade', name: 'Exu');
  }

  if (RegExp(
    r'\b(pomba\s*gira|pombagira|pombo\s*gira)\b',
    caseSensitive: false,
  ).hasMatch(normalized)) {
    return (type: 'entidade', name: 'Pomba Gira');
  }

  if (lower.contains('jurema')) {
    return (type: 'linha', name: 'Jurema');
  }

  if (lower.contains('aruanda')) {
    return (type: 'linha', name: 'Aruanda');
  }

  if (RegExp(r'\b7\s+linhas\b', caseSensitive: false).hasMatch(normalized) ||
      RegExp(r'\bsete\s+linhas\b', caseSensitive: false).hasMatch(normalized)) {
    return (type: 'linha', name: '7 Linhas');
  }

  if (lower.contains('abertura') || lower.contains('abre a gira')) {
    return (type: 'geral', name: 'Abertura');
  }

  return null;
}

CategoryResult _classifyByTextSignals(String title, String? lyrics) {
  final combined = '${title.trim()}\n${lyrics ?? ''}'.toLowerCase();

  final known = _findKnownEntity(combined);
  if (known != null) return known;

  final orixa = _findOrixa(combined);
  if (orixa != null) return orixa;

  if (RegExp(
    r'\b(pomba\s*gira|pombagira|pombo\s*gira)\b',
    caseSensitive: false,
  ).hasMatch(combined)) {
    return (type: 'entidade', name: 'Pomba Gira');
  }

  if (RegExp(r'\bexu\b', caseSensitive: false).hasMatch(combined)) {
    return (type: 'entidade', name: 'Exu');
  }

  if (RegExp(r'\bcaboclo\b', caseSensitive: false).hasMatch(combined) ||
      RegExp(r'\bcabloco\b', caseSensitive: false).hasMatch(combined)) {
    return (type: 'guia', name: 'Caboclos');
  }

  if (RegExp(r'\bpreto\s+velho\b', caseSensitive: false).hasMatch(combined) ||
      RegExp(r'\bvov[ôo]\b', caseSensitive: false).hasMatch(combined)) {
    return (type: 'guia', name: 'Pretos Velhos');
  }

  if (RegExp(r'\bboiadeir', caseSensitive: false).hasMatch(combined)) {
    return (type: 'guia', name: 'Boiadeiros');
  }

  if (RegExp(r'\bbaian', caseSensitive: false).hasMatch(combined)) {
    return (type: 'guia', name: 'Baianos');
  }

  if (RegExp(r'\bmarinheir', caseSensitive: false).hasMatch(combined)) {
    return (type: 'guia', name: 'Marinheiros');
  }

  if (RegExp(r'\bcigan', caseSensitive: false).hasMatch(combined)) {
    return (type: 'guia', name: 'Ciganos');
  }

  if (RegExp(
        r'\b(er[eê]|crian[çc])',
        caseSensitive: false,
      ).hasMatch(combined) ||
      RegExp(r'\bcosme\b', caseSensitive: false).hasMatch(combined) ||
      RegExp(r'\bdami[aã]o\b', caseSensitive: false).hasMatch(combined)) {
    return (type: 'guia', name: 'Crianças');
  }

  return (type: 'geral', name: 'Geral');
}

CategoryResult categorize(String title, String? lyrics) {
  final extracted = _extractLinhaPorTitulo(title);
  if (extracted != null) return extracted;
  return _classifyByTextSignals(title, lyrics);
}

void main(List<String> args) {
  final inputPath = args.isNotEmpty ? args.first : 'base/umbanda-letras.json';
  final file = File(inputPath);
  if (!file.existsSync()) {
    stderr.writeln('Arquivo não encontrado: $inputPath');
    exitCode = 2;
    return;
  }

  final raw = file.readAsStringSync();
  final decoded = jsonDecode(raw);
  if (decoded is! Map) {
    stderr.writeln('Formato inesperado: raiz não é objeto JSON.');
    exitCode = 2;
    return;
  }

  final root = decoded.cast<String, dynamic>();
  final itemsAny = root['items'];
  if (itemsAny is! List) {
    stderr.writeln('Formato inesperado: "items" não é lista.');
    exitCode = 2;
    return;
  }

  var categorized = 0;
  var total = 0;

  for (final it in itemsAny) {
    if (it is! Map) continue;
    final item = it.cast<String, dynamic>();
    total++;

    final title = (item['title'] ?? '').toString();
    final lyrics = item['lyrics']?.toString();
    final result = categorize(title, lyrics);

    item['categoryType'] = result.type;
    item['category'] = result.name;
    categorized++;
  }

  final encoder = const JsonEncoder.withIndent('  ');
  file.writeAsStringSync('${encoder.convert(root)}\n');
  stdout.writeln('Categorizadas: $categorized / $total');
}
