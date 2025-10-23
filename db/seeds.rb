# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in any environment.
# The data can then be loaded with the bin/rails db:seed command.

boards_data = [
  { board_number: 1, board_name: 'IKAN BESAR', synonyms: ['06', '13', '15', '24', '27', '31'] },
  { board_number: 2, board_name: 'BUAYA', synonyms: ['27', 'KASUT/DOMPET'] },
  { board_number: 3, board_name: 'SIPUT', synonyms: ['07', '17', 'CINCIN/INTAN'] },
  { board_number: 4, board_name: 'ITIK', synonyms: ['03', '37', 'KETCHAP/PONDAN'] },
  { board_number: 5, board_name: 'BURUNG', synonyms: ['14', '36', 'PADI/GANDUM'] },
  { board_number: 6, board_name: 'SINGA', synonyms: ['04', 'UBAT NYAMUK'] },
  { board_number: 7, board_name: 'ARNAB/BULAN', synonyms: ['17', '35', 'LAMPU/MANCHIS'] },
  { board_number: 8, board_name: 'BABI HIDUP', synonyms: ['14', '05', '24', 'KACA MATA'] },
  { board_number: 9, board_name: 'HARIMAU', synonyms: ['34', 'UBAT SAPU'] },
  { board_number: 10, board_name: 'LEMBU', synonyms: ['03', '06', 'BAYI/SUSU'] },
  { board_number: 11, board_name: 'SYAITAN', synonyms: ['13', '33', 'ARAK'] },
  { board_number: 12, board_name: 'GAJAH', synonyms: ['07', 'JAM'] },
  { board_number: 13, board_name: 'TIKUS', synonyms: ['19', 'PENJARA'] },
  { board_number: 14, board_name: 'KUDA JANTAN', synonyms: ['08', '05', '03', 'PISTOL/STC'] },
  { board_number: 15, board_name: 'HARIMAU BINTANG', synonyms: ['19', 'ASKAR'] },
  { board_number: 16, board_name: 'PENYENGAT', synonyms: ['09', 'INJECTION'] },
  { board_number: 17, board_name: 'BABI MATI', synonyms: ['30', 'MAYAT/KUBURAN'] },
  { board_number: 18, board_name: 'BANGAU', synonyms: ['10', 'KERBAU'] },
  { board_number: 19, board_name: 'KUCING', synonyms: ['25', '29', 'RADIO/BATERI'] },
  { board_number: 20, board_name: 'RAMA-RAMA', synonyms: ['11', 'WANG/MENTOL'] },
  { board_number: 21, board_name: 'LIPAN', synonyms: ['23', '33', 'EMAS/PEN'] },
  { board_number: 22, board_name: 'KUDA BETINA', synonyms: ['12', '15', 'SENAPANG'] },
  { board_number: 23, board_name: 'PELACUR', synonyms: ['27', '33', 'BUNGA ROS'] },
  { board_number: 24, board_name: 'MONYET', synonyms: ['13', '21', 'KELAPA/PISANG'] },
  { board_number: 25, board_name: 'PERAHU', synonyms: ['06', '26', 'PAYUNG/KATAK'] },
  { board_number: 26, board_name: 'KURA-KURA', synonyms: ['14', 'SISIR/KERETA'] },
  { board_number: 27, board_name: 'NAGA', synonyms: ['15', '25', 'API/PERAHU NAGA'] },
  { board_number: 28, board_name: 'ANJING', synonyms: ['19', 'POLIS/HOT DOG'] },
  { board_number: 29, board_name: 'AYAM JANTAN', synonyms: ['19', 'MATAHARI/KFC'] },
  { board_number: 30, board_name: 'BELUT', synonyms: ['16', '32', 'MARIAM/SUNGA API'] },
  { board_number: 31, board_name: 'IKAN KECIL', synonyms: ['1', '16', 'MAKANAN TIN'] },
  { board_number: 32, board_name: 'ULAR BESAR', synonyms: ['01', '17', '19', 'TONGKAT'] },
  { board_number: 33, board_name: 'PAYAU', synonyms: ['31', 'CLAUSPOL'] },
  { board_number: 34, board_name: 'UDANG', synonyms: ['05', '18', 'GITAR/BEI ACAN'] },
  { board_number: 35, board_name: 'AYAMBETINA', synonyms: ['24', '21', 'LABA LABA/PUKAT'] },
  { board_number: 36, board_name: 'KAMBING', synonyms: ['01', '17', '19'] },
  { board_number: 37, board_name: 'MUSANG', synonyms: ['13', '20', 'PENCURI/LANUN'] },
]

boards_data.each do |board_data|
  Board.find_or_create_by!(board_number: board_data[:board_number]) do |board|
    board.board_name = board_data[:board_name]
    board.synonyms = board_data[:synonyms]
  end
end
