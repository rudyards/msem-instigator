# frozen_string_literal: true

# This is loaded manually in format.rb, go there to tell it to load more formats or change the order.

class FormatPHM < Format
    def format_pretty_name
      'PHM'
    end
  
    def build_included_sets
      Set[
        'afm', 'kzd',
        'toj', 'imp', 'psa',
        'pfp', 'twr',
        'gnj', 'sur',
        'oph', 'orp',
        'cac', 'mac',
        'hi12',
        'k15',
        'klc',
        'mis',
        'nva',
        'poa',
        'sor',
        'tow',
        'ghq',
        'hvf',
        'zer',
        'l',
        'l2',
        'l3',
        '101',
        'vtm',
        'unr',
        'ms1', 'ms2', 'ms3', 'msc',
        'rwr',
        'atb',
        'dhl',
        'eau',
        'doa',
        'way',
        'law',
        'lvs',
        'kod',
        'stn',
        'sou',
        'alr',
        'mon',
        'dss','eia',
        'hzn',
        'rvo','akd',
        'byk','alk',
        'oth','ono',
        'qrb','swr',
        'fnv','kxp',
        'pax','njb',
        'aca','vhs','msj',
        'spk','rcm',
        'avx','ttr',
        'act', 'msl',
        'etf', 'btb'
      ]
    end
end
