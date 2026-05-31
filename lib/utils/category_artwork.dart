import '../models/category.dart';

/// Artes de categoria copiadas de `app_imgs/` → `assets/images/categories/`.
///
/// | Arquivo            | Categoria(s) mapeada(s)                          |
/// |--------------------|--------------------------------------------------|
/// | caboclo.webp        | Caboclos (CA)                                    |
/// | pretovelho.webp     | Pretos Velhos (PR)                               |
/// | exu.webp            | Egunitá _ Oroiná (EG) — linha de Exu/Egungun     |
/// | pombogira.webp      | Pombagira (fuzzy por nome)                       |
/// | bahiano.webp        | Bahiano (fuzzy por nome)                         |
/// | boiadeiro.webp      | Boiadeiro (fuzzy por nome)                       |
/// | marinheiro.webp     | Marinheiro (fuzzy por nome)                      |
/// | ere.webp            | Erê (fuzzy por nome)                             |
/// | oxala.webp          | Oxalá (OX)                                       |
/// | iemanja.webp        | Iemanjá (IE)                                     |
/// | ogum.webp           | Ogum (OG)                                        |
/// | oxossi.webp         | Oxossi (OX1)                                     |
/// | oxum.webp           | Oxum (OX2)                                       |
/// | xango.webp          | Xangô (XA)                                       |
/// | iansa.webp          | Iansã (IA)                                       |
/// | nana.webp           | Nanã Buruquê (NA)                                |
/// | oba.webp            | Obá (OB1)                                        |
/// | omolu.webp          | Omulu (OM)                                       |
/// | oxumare.webp        | Oxumarê (OX3)                                    |
/// | ibeji.webp          | Ibêji (fuzzy por nome — sem categoria no seed)   |
/// | ossain.webp         | Ossain (OS)                                      |
/// | logun_ede.webp      | Logun Edé (LO)                                   |
///
/// Sem imagem (categorias do seed): Obaluaiê (OB), Oiá Tempo _ Logunã (OI)
///
/// Não copiados (não são categorias): emblema, emblema_semfundo,
/// maria, maria_semfundo (ver assets/images/*.webp na raiz)
const _assetsRoot = 'assets/images/categories';

const _explicitByNormalizedName = <String, String>{
  'caboclos': '$_assetsRoot/caboclo.webp',
  'caboclo': '$_assetsRoot/caboclo.webp',
  'pretosvelhos': '$_assetsRoot/pretovelho.webp',
  'pretvelho': '$_assetsRoot/pretovelho.webp',
  'pretovelho': '$_assetsRoot/pretovelho.webp',
  'egunitaoroina': '$_assetsRoot/exu.webp',
  'egunita': '$_assetsRoot/exu.webp',
  'oroina': '$_assetsRoot/exu.webp',
  'exu': '$_assetsRoot/exu.webp',
  'pombagira': '$_assetsRoot/pombogira.webp',
  'pombogira': '$_assetsRoot/pombogira.webp',
  'bahiano': '$_assetsRoot/bahiano.webp',
  'boiadeiro': '$_assetsRoot/boiadeiro.webp',
  'marinheiro': '$_assetsRoot/marinheiro.webp',
  'ere': '$_assetsRoot/ere.webp',
  'oxala': '$_assetsRoot/oxala.webp',
  'obatala': '$_assetsRoot/oxala.webp',
  'iemanja': '$_assetsRoot/iemanja.webp',
  'yemanja': '$_assetsRoot/iemanja.webp',
  'ogum': '$_assetsRoot/ogum.webp',
  'oxossi': '$_assetsRoot/oxossi.webp',
  'oxum': '$_assetsRoot/oxum.webp',
  'xango': '$_assetsRoot/xango.webp',
  'chango': '$_assetsRoot/xango.webp',
  'iansa': '$_assetsRoot/iansa.webp',
  'yansa': '$_assetsRoot/iansa.webp',
  'nana': '$_assetsRoot/nana.webp',
  'nanaburuque': '$_assetsRoot/nana.webp',
  'oba': '$_assetsRoot/oba.webp',
  'omolu': '$_assetsRoot/omolu.webp',
  'oxumare': '$_assetsRoot/oxumare.webp',
  'ibeji': '$_assetsRoot/ibeji.webp',
  'ibei': '$_assetsRoot/ibeji.webp',
  'ossain': '$_assetsRoot/ossain.webp',
  'ossaim': '$_assetsRoot/ossain.webp',
  'logunede': '$_assetsRoot/logun_ede.webp',
  'logun_ede': '$_assetsRoot/logun_ede.webp',
  'logunedé': '$_assetsRoot/logun_ede.webp',
};

const _explicitByCode = <String, String>{
  'CA': '$_assetsRoot/caboclo.webp',
  'PR': '$_assetsRoot/pretovelho.webp',
  'EG': '$_assetsRoot/exu.webp',
  'OX': '$_assetsRoot/oxala.webp',
  'IE': '$_assetsRoot/iemanja.webp',
  'OG': '$_assetsRoot/ogum.webp',
  'OX1': '$_assetsRoot/oxossi.webp',
  'OX2': '$_assetsRoot/oxum.webp',
  'XA': '$_assetsRoot/xango.webp',
  'IA': '$_assetsRoot/iansa.webp',
  'NA': '$_assetsRoot/nana.webp',
  'OB1': '$_assetsRoot/oba.webp',
  'OM': '$_assetsRoot/omolu.webp',
  'OX3': '$_assetsRoot/oxumare.webp',
  'OS': '$_assetsRoot/ossain.webp',
  'LO': '$_assetsRoot/logun_ede.webp',
};

/// Chaves normalizadas dos arquivos disponíveis (stem do filename).
const _assetKeys = <String, String>{
  'caboclo': '$_assetsRoot/caboclo.webp',
  'pretovelho': '$_assetsRoot/pretovelho.webp',
  'exu': '$_assetsRoot/exu.webp',
  'pombogira': '$_assetsRoot/pombogira.webp',
  'bahiano': '$_assetsRoot/bahiano.webp',
  'boiadeiro': '$_assetsRoot/boiadeiro.webp',
  'marinheiro': '$_assetsRoot/marinheiro.webp',
  'ere': '$_assetsRoot/ere.webp',
  'oxala': '$_assetsRoot/oxala.webp',
  'iemanja': '$_assetsRoot/iemanja.webp',
  'ogum': '$_assetsRoot/ogum.webp',
  'oxossi': '$_assetsRoot/oxossi.webp',
  'oxum': '$_assetsRoot/oxum.webp',
  'xango': '$_assetsRoot/xango.webp',
  'iansa': '$_assetsRoot/iansa.webp',
  'nana': '$_assetsRoot/nana.webp',
  'oba': '$_assetsRoot/oba.webp',
  'omolu': '$_assetsRoot/omolu.webp',
  'oxumare': '$_assetsRoot/oxumare.webp',
  'ibeji': '$_assetsRoot/ibeji.webp',
  'ossain': '$_assetsRoot/ossain.webp',
  'logunede': '$_assetsRoot/logun_ede.webp',
};

String _normalizeCategoryKey(String input) {
  var s = input.toLowerCase().trim();
  const replacements = {
    'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a',
    'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
    'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
    'ó': 'o', 'ò': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
    'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
    'ç': 'c', 'ñ': 'n',
  };
  for (final entry in replacements.entries) {
    s = s.replaceAll(entry.key, entry.value);
  }
  return s.replaceAll(RegExp(r'[^a-z0-9]'), '');
}

String? categoryImageAsset(Category category) {
  return categoryImageAssetFor(name: category.name, code: category.code);
}

String? categoryImageAssetFor({required String name, String? code}) {
  final normalizedName = _normalizeCategoryKey(name);
  if (normalizedName.isNotEmpty) {
    final explicit = _explicitByNormalizedName[normalizedName];
    if (explicit != null) return explicit;
  }

  if (code != null && code.isNotEmpty) {
    final byCode = _explicitByCode[code.toUpperCase()];
    if (byCode != null) return byCode;
  }

  if (normalizedName.isNotEmpty) {
    for (final entry in _assetKeys.entries) {
      final key = entry.key;
      if (normalizedName.contains(key) || key.contains(normalizedName)) {
        return entry.value;
      }
    }
  }

  return null;
}
