# This is loaded manually in format.rb, go there to tell it to load more formats or change the order.

class FormatMSEDH < Format
  
  def format_pretty_name
    "MSEDH"
  end

def build_included_sets
    Set[
    "AFM", "KZD",
    "TOJ", "IMP", "PSA",
    "PFP", "TWR",
    "GNJ", "SUR",
    "OPH", "ORP",
    "CAC", "MAC",
    "DYA",
    "HI12",
    "K15",
    "KLC",
    "LNG",
    "MIS",
    "NVA",
    "POA",
    "SOR",
    "TGE",
    "TOW",
    "GHQ",
    "HVF",
    "XPM",
    "ZER",
    "L",
    "L2",
    "L3",
    "101",
    "VTM",
    "UNR",
    "MS1",
    "RWR",
    "ATB",
    "DHL",
    "EAU",
    "DOA",
    "WAY",
    "LAW",
    "WAW",
    "MS2",
    "LVS",
    "KOD",
    "STN"
    ]
end

end
