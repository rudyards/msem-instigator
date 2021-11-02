# frozen_string_literal: true

# This is loaded manually in format.rb, go there to tell it to load more formats or change the order.

class FormatPHM < Format
    def format_pretty_name
      'PHM'
    end
  
    def build_included_sets
      Set[
        'AFM', 'KZD',
        'TOJ', 'IMP', 'PSA',
        'PFP', 'TWR',
        'GNJ', 'SUR',
        'OPH', 'ORP',
        'CAC', 'MAC',
        'HI12',
        'K15',
        'KLC',
        'MIS',
        'NVA',
        'POA',
        'SOR',
        'TOW',
        'GHQ',
        'HVF',
        'ZER',
        'L',
        'L2',
        'L3',
        '101',
        'VTM',
        'UNR',
        'MS1', 'MS2', 'MS3',
        'RWR',
        'ATB',
        'DHL',
        'EAU',
        'DOA',
        'WAY',
        'LAW',
        'LVS',
        'KOD',
        'STN',
        'SOU',
        'ALR',
        'MON',
        'DSS','EIA',
        'HZN',
        'RVO','AKD'
      ]
    end
end