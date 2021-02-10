# frozen_string_literal: true

describe 'Formats - Standard' do
  include_context 'db'

  let(:regular_sets) do
    db.sets.values.select do |s|
      s.type == 'core' or s.type == 'expansion' or s.name =~ /Welcome Deck/
    end.to_set
  end

  describe 'Standard legal sets' do
    let(:start_date) { db.sets['mr'].release_date }
    let(:expected) { regular_sets.select { |set| set.release_date >= start_date }.map(&:code).to_set }
    let(:actual) { FormatStandard.new.rotation_schedule.values.flatten.to_set }
    it do
      expected.should eq actual
    end
  end

  it 'standard' do
    assert_block_composition 'standard', 'dom',  %w[kld aer akh w17 hou xln rix dom],
                             "Smuggler's Copter" => 'banned',
                             'Felidar Guardian' => 'banned',
                             'Aetherworks Marvel' => 'banned',
                             'Attune with Aether' => 'banned',
                             'Rogue Refiner' => 'banned',
                             'Rampaging Ferocidon' => 'banned',
                             'Ramunap Ruins' => 'banned'
    assert_block_composition 'standard', 'rix',  %w[kld aer akh w17 hou xln rix],
                             "Smuggler's Copter" => 'banned',
                             'Felidar Guardian' => 'banned',
                             'Aetherworks Marvel' => 'banned',
                             'Attune with Aether' => 'banned',
                             'Rogue Refiner' => 'banned',
                             'Rampaging Ferocidon' => 'banned',
                             'Ramunap Ruins' => 'banned'
    assert_block_composition 'standard', 'xln',  %w[kld aer akh w17 hou xln],
                             "Smuggler's Copter" => 'banned',
                             'Felidar Guardian' => 'banned',
                             'Aetherworks Marvel' => 'banned'
    assert_block_composition 'standard', 'hou',  %w[bfz ogw soi w16 emn kld aer akh w17 hou],
                             'Emrakul, the Promised End' => 'banned',
                             'Reflector Mage' => 'banned',
                             "Smuggler's Copter" => 'banned',
                             'Felidar Guardian' => 'banned',
                             'Aetherworks Marvel' => 'banned'
    assert_block_composition 'standard', 'akh',  %w[bfz ogw soi w16 emn kld aer akh w17],
                             'Emrakul, the Promised End' => 'banned',
                             'Reflector Mage' => 'banned',
                             "Smuggler's Copter" => 'banned',
                             'Felidar Guardian' => 'banned'
    assert_block_composition 'standard', 'aer',  %w[bfz ogw soi w16 emn kld aer],
                             'Emrakul, the Promised End' => 'banned',
                             'Reflector Mage' => 'banned',
                             "Smuggler's Copter" => 'banned'
    assert_block_composition 'standard', 'kld',  %w[bfz ogw soi w16 emn kld]
    assert_block_composition 'standard', 'emn',  %w[dtk ori bfz ogw soi w16 emn]
    assert_block_composition 'standard', 'soi',  %w[dtk ori bfz ogw soi w16]
    assert_block_composition 'standard', 'ogw',  %w[ktk frf dtk ori bfz ogw]
    assert_block_composition 'standard', 'bfz',  %w[ktk frf dtk ori bfz]
    assert_block_composition 'standard', 'ori',  %w[ths bng jou m15 ktk frf dtk ori]
    assert_block_composition 'standard', 'dtk',  %w[ths bng jou m15 ktk frf dtk]
    assert_block_composition 'standard', 'frf',  %w[ths bng jou m15 ktk frf]
    assert_block_composition 'standard', 'ktk',  %w[ths bng jou m15 ktk]
    assert_block_composition 'standard', 'm15',  %w[rtr gtc dgm m14 ths bng jou m15]
    assert_block_composition 'standard', 'jou',  %w[rtr gtc dgm m14 ths bng jou]
    assert_block_composition 'standard', 'bng',  %w[rtr gtc dgm m14 ths bng]
    assert_block_composition 'standard', 'ths',  %w[rtr gtc dgm m14 ths]
    assert_block_composition 'standard', 'm14',  %w[isd dka avr m13 rtr gtc dgm m14]
    assert_block_composition 'standard', 'dgm',  %w[isd dka avr m13 rtr gtc dgm]
    assert_block_composition 'standard', 'gtc',  %w[isd dka avr m13 rtr gtc]
    assert_block_composition 'standard', 'rtr',  %w[isd dka avr m13 rtr]
    assert_block_composition 'standard', 'm13',  %w[som mbs nph m12 isd dka avr m13]
    assert_block_composition 'standard', 'avr',  %w[som mbs nph m12 isd dka avr]
    assert_block_composition 'standard', 'dka',  %w[som mbs nph m12 isd dka]
    assert_block_composition 'standard', 'isd',  %w[som mbs nph m12 isd]
    assert_block_composition 'standard', 'm12',  %w[zen wwk roe m11 som mbs nph m12],
                             'Jace, the Mind Sculptor' => 'banned',
                             'Stoneforge Mystic' => 'banned'
    assert_block_composition 'standard', Date.parse('2011-07-01'), %w[zen wwk roe m11 som mbs nph],
                             'Jace, the Mind Sculptor' => 'banned',
                             'Stoneforge Mystic' => 'banned'
    assert_block_composition 'standard', 'nph',  %w[zen wwk roe m11 som mbs nph]
    assert_block_composition 'standard', 'mbs',  %w[zen wwk roe m11 som mbs]
    assert_block_composition 'standard', 'som',  %w[zen wwk roe m11 som]
    assert_block_composition 'standard', 'm11',  %w[ala cfx arb m10 zen wwk roe m11]
    assert_block_composition 'standard', 'roe',  %w[ala cfx arb m10 zen wwk roe]
    assert_block_composition 'standard', 'wwk',  %w[ala cfx arb m10 zen wwk]
    assert_block_composition 'standard', 'zen',  %w[ala cfx arb m10 zen]
    assert_block_composition 'standard', 'm10',  %w[lw mt shm eve ala cfx arb m10]
    assert_block_composition 'standard', 'arb',  %w[10e lw mt shm eve ala cfx arb]
    assert_block_composition 'standard', 'cfx',  %w[10e lw mt shm eve ala cfx]
    assert_block_composition 'standard', 'ala',  %w[10e lw mt shm eve ala]
    assert_block_composition 'standard', 'eve',  %w[cs ts tsts pc fut 10e lw mt shm eve]
    assert_block_composition 'standard', 'shm',  %w[cs ts tsts pc fut 10e lw mt shm]
    assert_block_composition 'standard', 'mt',   %w[cs ts tsts pc fut 10e lw mt]
    assert_block_composition 'standard', 'lw',   %w[cs ts tsts pc fut 10e lw]
    assert_block_composition 'standard', '10e',  %w[rav gp di cs ts tsts pc fut 10e]
    assert_block_composition 'standard', 'fut',  %w[9e rav gp di cs ts tsts pc fut]
    assert_block_composition 'standard', 'pc',   %w[9e rav gp di cs ts tsts pc]
    assert_block_composition 'standard', 'tsts', %w[9e rav gp di cs ts tsts]
    assert_block_composition 'standard', 'ts',   %w[9e rav gp di cs ts tsts]
    assert_block_composition 'standard', 'cs',   %w[chk bok sok 9e rav gp di cs]
    assert_block_composition 'standard', 'di',   %w[chk bok sok 9e rav gp di]
    assert_block_composition 'standard', 'gp',   %w[chk bok sok 9e rav gp]
    assert_block_composition 'standard', 'rav',  %w[chk bok sok 9e rav]
    assert_block_composition 'standard', '9e',   %w[mi ds 5dn chk bok sok 9e],
                             'Ancient Den' => 'banned',
                             'Arcbound Ravager' => 'banned',
                             'Darksteel Citadel' => 'banned',
                             'Disciple of the Vault' => 'banned',
                             'Great Furnace' => 'banned',
                             'Seat of the Synod' => 'banned',
                             'Skullclamp' => 'banned',
                             'Tree of Tales' => 'banned',
                             'Vault of Whispers' => 'banned'
    assert_block_composition 'standard', 'sok',  %w[8e mi ds 5dn chk bok sok],
                             'Ancient Den' => 'banned',
                             'Arcbound Ravager' => 'banned',
                             'Darksteel Citadel' => 'banned',
                             'Disciple of the Vault' => 'banned',
                             'Great Furnace' => 'banned',
                             'Seat of the Synod' => 'banned',
                             'Skullclamp' => 'banned',
                             'Tree of Tales' => 'banned',
                             'Vault of Whispers' => 'banned'
    assert_block_composition 'standard', 'bok',  %w[8e mi ds 5dn chk bok],
                             'Skullclamp' => 'banned'
    assert_block_composition 'standard', 'chk',  %w[8e mi ds 5dn chk],
                             'Skullclamp' => 'banned'
    assert_block_composition 'standard', '5dn',  %w[on le sc 8e mi ds 5dn]
    assert_block_composition 'standard', 'ds',   %w[on le sc 8e mi ds]
    assert_block_composition 'standard', 'mi',   %w[on le sc 8e mi]
    assert_block_composition 'standard', '8e',   %w[od tr ju on le sc 8e]

    # Weird things happening from this point back..., ap came after 7e but will rotate earlier if I understand correctly
    # It's not guarenteed to be correct

    assert_block_composition 'standard', 'sc',   %w[7e od tr ju on le sc]
    assert_block_composition 'standard', 'le',   %w[7e od tr ju on le]
    assert_block_composition 'standard', 'on',   %w[7e od tr ju on]
    assert_block_composition 'standard', 'ju',   %w[in ps 7e ap od tr ju]
    assert_block_composition 'standard', 'tr',   %w[in ps 7e ap od tr]
    assert_block_composition 'standard', 'od',   %w[in ps 7e ap od]
    assert_block_composition 'standard', 'ap',   %w[mm ne pr in ps 7e ap]
    assert_block_composition 'standard', '7e',   %w[mm ne pr in ps 7e]
    assert_block_composition 'standard', 'ps',   %w[6e mm ne pr in ps]
    assert_block_composition 'standard', 'in',   %w[6e mm ne pr in]
    assert_block_composition 'standard', 'pr',   %w[us ul 6e ud mm ne pr],
                             'Fluctuator' => 'banned',
                             'Memory Jar' => 'banned',
                             'Time Spiral' => 'banned',
                             'Tolarian Academy' => 'banned',
                             'Windfall' => 'banned'
    assert_block_composition 'standard', 'ne',   %w[us ul 6e ud mm ne],
                             'Fluctuator' => 'banned',
                             'Memory Jar' => 'banned',
                             'Time Spiral' => 'banned',
                             'Tolarian Academy' => 'banned',
                             'Windfall' => 'banned'
    assert_block_composition 'standard', 'mm',   %w[us ul 6e ud mm],
                             'Fluctuator' => 'banned',
                             'Memory Jar' => 'banned',
                             'Time Spiral' => 'banned',
                             'Tolarian Academy' => 'banned',
                             'Windfall' => 'banned'
    assert_block_composition 'standard', 'ud',   %w[tp sh ex us ul 6e ud],
                             'Dream Halls' => 'banned',
                             'Earthcraft' => 'banned',
                             'Fluctuator' => 'banned',
                             'Lotus Petal' => 'banned',
                             'Memory Jar' => 'banned',
                             'Recurring Nightmare' => 'banned',
                             'Time Spiral' => 'banned',
                             'Tolarian Academy' => 'banned',
                             'Windfall' => 'banned'
    assert_block_composition 'standard', '6e',   %w[tp sh ex us ul 6e],
                             'Dream Halls' => 'banned',
                             'Earthcraft' => 'banned',
                             'Fluctuator' => 'banned',
                             'Lotus Petal' => 'banned',
                             'Memory Jar' => 'banned',
                             'Recurring Nightmare' => 'banned',
                             'Time Spiral' => 'banned',
                             'Tolarian Academy' => 'banned',
                             'Windfall' => 'banned'
    assert_block_composition 'standard', 'ul',   %w[5e tp sh ex us ul],
                             'Tolarian Academy' => 'banned',
                             'Windfall' => 'banned'
    assert_block_composition 'standard', 'us',   %w[5e tp sh ex us]
    assert_block_composition 'standard', 'ex',   %w[mr vi 5e wl tp sh ex]
    assert_block_composition 'standard', 'sh',   %w[mr vi 5e wl tp sh]
    assert_block_composition 'standard', 'tp',   %w[mr vi 5e wl tp]

    # There aren't clear blocks going that far back
    # There was also time when Standard had ABUR duals explicitly added to it...
    # This ought to be fixed someday, but it's not urgent

    # assert_block_composition "standard", "wl",   [???, "mr", "vi", "5e", "wl"]
    # assert_block_composition "standard", "5e",   [???]
    # assert_block_composition "standard", "vi",   [???]
    # assert_block_composition "standard", "mr",   [???]
    # assert_block_composition "standard", "ai",   [???]
    # assert_block_composition "standard", "hl",   [???]
    # assert_block_composition "standard", "ia",   [???]
    # assert_block_composition "standard", "4e",   [???]
    # assert_block_composition "standard", "fe",   [???]
    # assert_block_composition "standard", "dk",   [???]
    # assert_block_composition "standard", "lg",   [???]
    # assert_block_composition "standard", "rv",   [???]
    # assert_block_composition "standard", "aq",   [???]
    # assert_block_composition "standard", "un",   [???]
    # assert_block_composition "standard", "an",   [???]
    # assert_block_composition "standard", "be",   [???]
    # assert_block_composition "standard", "al",   [???]
  end
end
