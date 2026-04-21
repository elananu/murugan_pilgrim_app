import 'package:flutter/material.dart';

class Temple {
  final int id;
  final String name;
  final String tamil;
  final String location;
  final String distance;
  final String deity;
  final String type;
  final double lat;
  final double lng;
  final Color color;
  final List<Color> gradient;
  final String emoji;
  final String imagePath;
  final String history;
  final List<Map<String, String>> darshanTimings;
  final List<String> poojaTimings;
  final List<String> facilities;
  final List<String> festivals;
  final String bookingUrl;
  final String darshanInfoUrl;
  final String nearbyBus;
  final String nearbyRailway;
  final Map<String, String> travelInfo;
  final List<Map<String, String>> hotels; // ← changed from List<String>
  final List<String> restaurants;

  const Temple({
    required this.id,
    required this.name,
    required this.tamil,
    required this.location,
    required this.distance,
    required this.deity,
    required this.type,
    required this.lat,
    required this.lng,
    required this.color,
    required this.gradient,
    required this.emoji,
    required this.imagePath,
    required this.history,
    required this.darshanTimings,
    required this.poojaTimings,
    required this.facilities,
    required this.festivals,
    required this.bookingUrl,
    required this.darshanInfoUrl,
    required this.nearbyBus,
    required this.nearbyRailway,
    required this.travelInfo,
    required this.hotels,
    required this.restaurants,
  });
}

final List<Temple> temples = [
  Temple(
    id: 1,
    name: 'Thiruparankundram',
    tamil: 'திருப்பரங்குன்றம்',
    location: 'Madurai, Tamil Nadu',
    distance: '9 km from Madurai',
    deity: 'Subramanya Swami',
    type: 'Cave Temple',
    lat: 9.8928,
    lng: 78.0719,
    color: const Color(0xFFFF6B35),
    gradient: const [Color(0xFFFF6B35), Color(0xFFFF8C42)],
    emoji: '🏔️',
    imagePath: 'assets/images/temples/thiruparankundram.jpg',
    history:
        'Arulmigu Subramaniya Swamy temple is situated in Thiruparankundram which is one of the 6 among abodes of lord Muruga. Sangam treat like Paripadal, Thirumurugatrupadai and Madurai Kanchi praise this ancient Temple. From that Saiva samayakuravas Thirugnana Sambhandhar, Sundarar, Manikkavasakar have also sung praise songs on the temple. The temple was a rock cut temple. This temple originated as Kudaivari temple during the period of Earlier Pandya Kings and was flourised during the period of later Pandya Kings. During the Nayak period, it flourished with Mandapas and Gopurams. The Nedinjadayan Paranthakan era copper plates, who ruled with the title Sadayavarman (765-815 AD), are available in the London British museum and Chennai museum. This vatteluttu inscription is dated in the 6th year of Maranchadaiyan. It records the reconstruction of the Thirukovil and of the Sree thadagam by Sattan Ganapathi, resident of karavanthapura. The compound wall and main entrance tower was completed in response to Veerappa nayakar at saga year 1505 AD. In 1659 AD Thirumalai Nayakar has erected an idol of himself and two of his wives as if he had always worshiped Lord Murugan.',
    darshanTimings: const [
      {'session': 'Morning', 'time': '5:30 AM – 12:30 PM'},
      {'session': 'Evening', 'time': '4:00 PM – 9:00 PM'},
    ],
    poojaTimings: const [
      'Thiruvanandal – 5:30 AM',
      'Kalaasandhi – 8:00 AM',
      'Uchikalam – 10:00 AM',
      'Sayarakshai – 6:00 PM',
      'Irandamkalam – 7:30 PM',
      'Ardha Jamam – 9:00 PM',
    ],
    facilities: const ['Parking Available', 'Restrooms', 'Cloak Room', 'Drinking Water', 'Medical Aid'],
    festivals: const ['Thai Poosam', 'Skanda Shashti', 'Panguni Uthiram', 'Karthigai Deepam'],
    bookingUrl: 'https://thiruparankundrammurugan.hrce.tn.gov.in/ticketing/service_collectionindex.php',
    darshanInfoUrl: 'https://darshansbooking.com/thiruparankundram-murugan-temple-darshan/',
    nearbyBus: 'Madurai Central Bus Stand (7 km)',
    nearbyRailway: 'Madurai Junction (10 km)',
    travelInfo: const {
      'bus': 'Buses available from Madurai Central Bus Stand every 30 mins.',
      'train': 'Nearest station: Madurai Junction. Auto/taxi available to temple.',
    },
    hotels: const [
      {'name': 'Vaani Villa', 'location': 'Thiruparankundram', 'distance': '1.7 km'},
      {'name': 'Hotel Alps Residency', 'location': 'Thiruparankundram', 'distance': '1.6 km'},
      {'name': 'Coral Shelters Pykara', 'location': 'Tirupparankunram Road', 'distance': '3.4 km'},
      {'name': 'Regency Madurai by GRT Hotels', 'location': 'Muthuramalingapuram', 'distance': '4.9 km'},
      {'name': 'Gateway Madurai', 'location': 'Pasumalai', 'distance': '4.1 km'},
      {'name': 'MAX HOTELS', 'location': 'Ponmeni', 'distance': '6.1 km'},
      {'name': 'Hotel Venkateswaraa', 'location': 'Jaihindpuram', 'distance': '5.9 km'},
      {'name': 'Hotel Lotus', 'location': 'Madurai Main', 'distance': '8 km'},
      {'name': 'Heritage Residency', 'location': 'Vilangudi', 'distance': '9 km'},
    ],
    restaurants: const ['Sri Acharya Bhavan', 'Sree Sabarees', 'Murugan Idli Shop', 'Hotel Anandha', 'Shree Lakshmi Bhavan'],
  ),
  Temple(
    id: 2,
    name: 'Thiruttani',
    tamil: 'திருத்தணி',
    location: 'Tiruvallur, Tamil Nadu',
    distance: '84 km from Chennai',
    deity: 'Thandayuthapani',
    type: 'Hill Temple',
    lat: 13.1833,
    lng: 79.6167,
    color: const Color(0xFFE91E63),
    gradient: const [Color(0xFFE91E63), Color(0xFFC2185B)],
    emoji: '⛰️',
    imagePath: 'assets/images/temples/thiruttani.jpg',
    history:
        'In Tirupupugazh, written by Arunagirinathar, one of the famous devotional literatures, it is stated that Lord Muruga married Valli in this Thiruthalam and sat on this hill as the fifth abode of worship. Kachiyapar in his Kanda Purana mentions that, like a lotus among flowers, Ganges among rivers, Kanchipuram among places, Thirutanigai is the best among mountains.',
    darshanTimings: const [
      {'session': 'Morning', 'time': '6:00 AM – 12:00 PM'},
      {'session': 'Evening', 'time': '4:00 PM – 9:00 PM'},
    ],
    poojaTimings: const [
      'Thiruvanandal – 6:00 AM',
      'Kalaasandhi – 8:30 AM',
      'Uchikalam – 11:00 AM',
      'Sayarakshai – 5:30 PM',
      'Irandamkalam – 7:00 PM',
      'Ardha Jamam – 9:00 PM',
    ],
    facilities: const ['Parking', 'Restrooms', 'Temple Cart', 'Drinking Water', 'Elevator Available'],
    festivals: const ['Skanda Shashti', 'Thai Poosam', 'Vaikasi Visakam'],
    bookingUrl: 'https://tiruttanimurugan.hrce.tn.gov.in/',
    darshanInfoUrl: 'https://darshansbooking.com/thiruthani-murugan-temple-darshan/',
    nearbyBus: 'Thiruttani Bus Stand (1 km)',
    nearbyRailway: 'Thiruttani Railway Station (2 km)',
    travelInfo: const {
      'bus': 'Direct buses from Chennai Koyambedu, Vellore, and Tirupati every 1 hour.',
      'train': 'Thiruttani station on Chennai–Tirupati line. Frequent trains available.',
    },
    hotels: const [
      {'name': 'Regency Tiruttani by GRT Hotels', 'location': 'Thiruthani', 'distance': '1.5 km'},
      {'name': 'Indra Regency', 'location': 'Nehru Nagar', 'distance': '1 km'},
      {'name': 'Sri Kumaran Lodge', 'location': 'Arakkonam Road', 'distance': '1.2 km'},
      {'name': 'VP Residency Towers', 'location': 'Arakkonam Road', 'distance': '1.3 km'},
      {'name': 'Hotel Skanda Palace', 'location': 'Thiruthani', 'distance': '1.4 km'},
      {'name': 'Kasettys Studio House', 'location': 'Thiruthani', 'distance': '1.1 km'},
      {'name': 'Mayura Residency', 'location': 'Nehru Nagar', 'distance': '1 km'},
      {'name': 'Mount View Residency', 'location': 'Thiruthani Hill', 'distance': '0.8 km'},
      {'name': 'Sri Lakshmi Residency', 'location': 'Senthamil Nagar', 'distance': '1.3 km'},
      {'name': 'AK Residency', 'location': 'Arakkonam Road', 'distance': '1.2 km'},
      {'name': 'Farm Shaala', 'location': 'Murukkambattu', 'distance': '3 km'},
    ],
    restaurants: const ['Hotel Babu Bhavan', 'Kumara Bhavan Hotel', 'Deeksha Hotel'],
  ),
  Temple(
    id: 3,
    name: 'Swamimalai',
    tamil: 'சுவாமிமலை',
    location: 'Kumbakonam, Tamil Nadu',
    distance: '8 km from Kumbakonam',
    deity: 'Swaminatha Swami',
    type: 'Hilltop Temple',
    lat: 10.9739,
    lng: 79.3284,
    color: const Color(0xFF9C27B0),
    gradient: const [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
    emoji: '🌿',
    imagePath: 'assets/images/temples/swamimalai.jpg',
    history:
        'Thanjavur district, 6 km west of Kumbakonam is Swamimalai, Swaminathaswamy temple. Thiruthalam is the fourth of the six houses of Lord Muruga. It is the famous place where om of Pranava Mantra was preached to his father Lord Shiva.',
    darshanTimings: const [
      {'session': 'Morning', 'time': '6:00 AM – 12:30 PM'},
      {'session': 'Evening', 'time': '4:00 PM – 8:30 PM'},
    ],
    poojaTimings: const [
      'Thiruvanandal – 6:00 AM',
      'Kalaasandhi – 8:00 AM',
      'Uchikalam – 10:30 AM',
      'Sayarakshai – 6:00 PM',
      'Irandamkalam – 7:30 PM',
    ],
    facilities: const ['Parking', 'Restrooms', 'Prasad Shop', 'Drinking Water'],
    festivals: const ['Skanda Shashti', 'Thai Poosam', 'Panguni Uthiram', 'Aadi Krithigai'],
    bookingUrl: 'https://hindutva.online/swamimalai-temple-timings-darshan-festivals/',
    darshanInfoUrl: 'https://hindutva.online/swamimalai-temple-timings-darshan-festivals/',
    nearbyBus: 'Kumbakonam Bus Stand (8 km)',
    nearbyRailway: 'Kumbakonam Railway Station (8 km)',
    travelInfo: const {
      'bus': 'Frequent buses from Kumbakonam, Thanjavur, and Trichy to Swamimalai.',
      'train': 'Nearest station: Kumbakonam. Auto/taxi to temple from station.',
    },
    hotels: const [
      {'name': 'Indeco Hotels Swamimalai', 'location': 'Swamimalai', 'distance': '0.5 km'},
      {'name': 'Mayapuri Amira', 'location': 'Swamimalai', 'distance': '0.5 km'},
      {'name': 'Royal Park Inn', 'location': 'Swamimalai', 'distance': '0.6 km'},
      {'name': 'Hotel Royal Park', 'location': 'Swamimalai', 'distance': '0.2 km'},
      {'name': 'Hotel Namaskar', 'location': 'Swamimalai', 'distance': '0.1 km'},
      {'name': 'Jayam Lodge', 'location': 'Swamimalai', 'distance': '0.3 km'},
      {'name': 'Thirumalai Home Stay', 'location': 'Kumbakonam', 'distance': '1.8 km'},
      {'name': 'Cholaa Dynasty - A Bergamont Hotel', 'location': 'Thiyagasamudram', 'distance': '3.3 km'},
      {'name': 'Hotel Temple City', 'location': 'Kumbakonam', 'distance': '4.1 km'},
      {'name': 'Kumbakonam Inn Hotels', 'location': 'Kumbakonam', 'distance': '4.3 km'},
      {'name': 'Lee Benz Ark Hotel', 'location': 'Anna Nagar', 'distance': '6.8 km'},
      {'name': 'Sri Baalaaji Grand', 'location': 'Kumbakonam', 'distance': '5.8 km'},
      {'name': 'Kings Bury Inn', 'location': 'Kumbakonam', 'distance': '7.2 km'},
    ],
    restaurants: const ['Muthu Idly Kadai', 'Sree Athi Ganesh Bhavan', 'Hotel Saravanas'],
  ),
  Temple(
    id: 4,
    name: 'Palani',
    tamil: 'பழனி',
    location: 'Dindigul, Tamil Nadu',
    distance: '100 km from Coimbatore',
    deity: 'Dhandayuthapani',
    type: 'Hill Temple',
    lat: 10.4472,
    lng: 77.5249,
    color: const Color(0xFFFF9800),
    gradient: const [Color(0xFFFF9800), Color(0xFFF57C00)],
    emoji: '🏯',
    imagePath: 'assets/images/temples/palani.jpg',
    history:
        'The specialty of Tirumala Thiruvarul — Palani has timeless antiquity and pride. In Tamil literature it is known as Sithan Haiva. At a distance of about 4 km from Palani, the Kodaikanal hill, which is a part of the western mountain range, appears green with silvery peaks. The Thirumeni of Lord Muruga was created by a Siddha called Bogar along with nine types of medicines (navabhasana). Shanmukha river is 2 km west of this place. The Six Rivers namely Palaru, Varatharu, Bhatularu, Suruliyaru, Kallaru and Pachaiyaru come together to form the name Shanmukha River.',
    darshanTimings: const [
      {'session': 'Morning', 'time': '5:00 AM – 1:00 PM'},
      {'session': 'Evening', 'time': '3:30 PM – 9:00 PM'},
    ],
    poojaTimings: const [
      'Thiruvanandal – 5:00 AM',
      'Kalaasandhi – 8:00 AM',
      'Uchikalam – 11:00 AM',
      'Sayarakshai – 5:30 PM',
      'Irandamkalam – 7:00 PM',
      'Ardha Jamam – 9:00 PM',
    ],
    facilities: const ['Rope Car / Winch', 'Parking', 'Restrooms', 'Cloak Room', 'Medical Center', 'Prasad Shop'],
    festivals: const ['Thai Poosam', 'Skanda Shashti', 'Panguni Uthiram', 'Vaikasi Visakam'],
    bookingUrl: 'https://palanimurugan.hrce.tn.gov.in/',
    darshanInfoUrl: 'https://templetimings.in/pmtdpst/',
    nearbyBus: 'Palani Bus Stand (1 km)',
    nearbyRailway: 'Palani Railway Station (2 km)',
    travelInfo: const {
      'bus': 'Frequent buses from Coimbatore, Madurai, Chennai, and Trichy.',
      'train': 'Palani station on Dindigul–Pollachi line. Regular trains available.',
    },
    hotels: const [
      {'name': 'Viruksham Residency', 'location': 'Palani', 'distance': '0.35 km'},
      {'name': 'Velan Temple View', 'location': 'Palani', 'distance': '0.5 km'},
      {'name': 'Jayam Hotel', 'location': 'Palayam', 'distance': '1.4 km'},
      {'name': 'Sampath Residency', 'location': 'South Anna Nagar', 'distance': '1.9 km'},
      {'name': 'Hotel Amoha', 'location': 'South Anna Nagar', 'distance': '1.5 km'},
      {'name': 'Hotel Nakshathra - A Royal Stay', 'location': 'Palani', 'distance': '1.1 km'},
      {'name': 'Mayura Palani', 'location': 'South Anna Nagar', 'distance': '0.4 km'},
      {'name': 'Hotel Divine Fort', 'location': 'South Anna Nagar', 'distance': '0.98 km'},
      {'name': 'Regency Palani by GRT Hotels', 'location': 'Vinayakar Kovil', 'distance': '3.4 km'},
      {'name': 'Ponnis Hotel', 'location': 'South Anna Nagar', 'distance': '1.6 km'},
      {'name': 'Eshwaraa Cottage', 'location': 'South Anna Nagar', 'distance': '1.8 km'},
      {'name': 'SKB Hotels', 'location': 'South Anna Nagar', 'distance': '1.4 km'},
      {'name': 'EdenAPark', 'location': 'South Anna Nagar', 'distance': '1.4 km'},
      {'name': 'Hotel SR Palani', 'location': 'Palani', 'distance': '1.9 km'},
      {'name': 'Hotel Sownthariyam', 'location': 'Anna Nagar', 'distance': '2.1 km'},
      {'name': 'Sara Regency', 'location': 'South Anna Nagar', 'distance': '1.8 km'},
    ],
    restaurants: const ['Hotel Nalapakam', 'Hotel Gowri Kkrishna', 'Sri Baalji Bhavan', 'Tamizhan Unavagam'],
  ),
  Temple(
    id: 5,
    name: 'Pazhamudircholai',
    tamil: 'பழமுதிர்சோலை',
    location: 'Madurai, Tamil Nadu',
    distance: '25 km from Madurai',
    deity: 'Kallazhagar / Murugan',
    type: 'Forest Temple',
    lat: 9.9816,
    lng: 78.1,
    color: const Color(0xFF4CAF50),
    gradient: const [Color(0xFF4CAF50), Color(0xFF388E3C)],
    emoji: '🌳',
    imagePath: 'assets/images/temples/pazhamudircholai.jpg',
    history:
        'Lord Murugan played in this holy place in a divine play of fruit felling. The Silapathikaram says that this place was situated on the way to Madurai in ancient times. The grand lady poet Avvai was going towards Madurai. Lord Murugan, disguised as a cowboy, climbed a jamun (Naval) fruit tree and waited for her. When Avvai sat under the tree to rest, the cowboy asked if she needed fruit. He shook the branch and ripe fruits fell on the sand. As Avvai blew on them to remove the sand, the cowboy laughed and said the fruit was hot. Through this divine play, Lord Murugan revealed that worldly desires are like sand — only consciousness, not mere knowledge, can remove them. The series of jamun trees near the temple miraculously yields fruit only during the Aipasi Tamil month during the Kantha Sasti festival. As the wisdom fruit, Murugan gave the Gnanappazham — this place bears the name Pazhamuthir Solai.',
    darshanTimings: const [
      {'session': 'Morning', 'time': '6:00 AM – 12:00 PM'},
      {'session': 'Evening', 'time': '3:00 PM – 8:00 PM'},
    ],
    poojaTimings: const [
      'Thiruvanandal – 6:00 AM',
      'Kalaasandhi – 9:00 AM',
      'Uchikalam – 11:00 AM',
      'Sayarakshai – 5:00 PM',
      'Irandamkalam – 7:00 PM',
    ],
    facilities: const ['Forest Path', 'Parking', 'Restrooms', 'Prasad Shop'],
    festivals: const ['Vaikasi Visakam', 'Thai Poosam', 'Aadi Poosam', 'Panguni Uthiram'],
    bookingUrl: 'https://www.temples.bio/temples/pazhamudircholai-murugan-temple-tamil-nadu/timings',
    darshanInfoUrl: 'https://www.temples.bio/temples/pazhamudircholai-murugan-temple-tamil-nadu/timings',
    nearbyBus: 'Alagar Kovil Bus Stand (0.5 km)',
    nearbyRailway: 'Madurai Junction (25 km)',
    travelInfo: const {
      'bus': 'Buses from Madurai Mattuthavani bus stand to Alagar Kovil every 30 mins.',
      'train': 'Nearest station: Madurai Junction. Take bus or taxi from there.',
    },
    hotels: const [
      {'name': 'Hotel Sabareesh Plaza', 'location': 'Madurai Main', 'distance': '1.7 km'},
      {'name': 'Hotel Lotus', 'location': 'Madurai Main', 'distance': '2.7 km'},
      {'name': 'Hotel Temple View', 'location': 'Madurai Main', 'distance': '1.7 km'},
      {'name': 'Hotel Annapoorna Residency', 'location': 'Madurai Main', 'distance': '1.9 km'},
      {'name': 'Madurai Residency', 'location': 'Madurai Main', 'distance': '2.1 km'},
      {'name': 'Sree Madhura Residency', 'location': 'Madurai Main', 'distance': '1.8 km'},
      {'name': 'MAX HOTELS', 'location': 'Ponmeni', 'distance': '4.4 km'},
      {'name': 'TTDC Hotel Tamil Nadu - Madurai 1', 'location': 'Madurai Main', 'distance': '2.4 km'},
      {'name': 'Hotel Rajadhane', 'location': 'KK Nagar', 'distance': '4.6 km'},
      {'name': 'Hotel Prem Nivas', 'location': 'Madurai Main', 'distance': '2.7 km'},
      {'name': 'Eden Garden By Jolly Homes', 'location': 'Madurai', 'distance': '2.3 km'},
      {'name': 'Hotel Vijay', 'location': 'Madurai Main', 'distance': '2.2 km'},
      {'name': 'Cosmopolitan Hotels', 'location': 'Southern Railway Colony', 'distance': '2.6 km'},
      {'name': 'JC Residency', 'location': 'Chinna Chokkikulam', 'distance': '3.2 km'},
    ],
    restaurants: const ['Murugan Idli Shop', 'Shree Lakshmi Bhavan', 'Surya Veg Restaurant'],
  ),
  Temple(
    id: 6,
    name: 'Thiruchendur',
    tamil: 'திருச்செந்தூர்',
    location: 'Thoothukudi, Tamil Nadu',
    distance: '60 km from Tirunelveli',
    deity: 'Senthil Andavar',
    type: 'Seashore Temple',
    lat: 8.4952,
    lng: 78.1202,
    color: const Color(0xFF2196F3),
    gradient: const [Color(0xFF2196F3), Color(0xFF1565C0)],
    emoji: '🌊',
    imagePath: 'assets/images/temples/thiruchendur.jpg',
    history:
        'The Seashore temple of Subramanya Swamy at Tiruchendur is one of the delightful spots sanctified and venerated by every Hindu, located at the extreme southwest of the Indian peninsula. The nucleus of the structure has been here for more than 2,000 years as the Tamil Classics attest. In the Thirumurugatruppadai, six chosen spots in the Tamil land are referred to by Nakkirar as of more than ordinary sanctity, and Tiruchendur occupies the second place. Uncommonly, this temple is located on the seashore, while the rest of Murugan\'s temples are on hill tops. A noble Sanyasin, Mouna Swami, saw the original sandstone structure in disrepair and undertook renovation, followed by Kasi Swamigal and Arumuga Swamigal. Over 72 years the structure was rebuilt entirely in imperishable black granite. The temple was fully reconstructed and Kumbabisheka performed in 1941. The West Gopuram has nine floors built on the extremity of a sandstone cliff, visible at sea for twelve miles around.',
    darshanTimings: const [
      {'session': 'Morning', 'time': '5:30 AM – 1:00 PM'},
      {'session': 'Evening', 'time': '4:00 PM – 9:00 PM'},
    ],
    poojaTimings: const [
      'Thiruvanandal – 5:30 AM',
      'Kalaasandhi – 7:30 AM',
      'Uchikalam – 10:30 AM',
      'Sayarakshai – 5:30 PM',
      'Irandamkalam – 7:30 PM',
      'Ardha Jamam – 9:30 PM',
    ],
    facilities: const ['Sea Bath Ghat', 'Parking', 'Restrooms', 'Cloak Room', 'Medical Aid', 'Prasad Shop'],
    festivals: const ['Skanda Shashti', 'Thai Poosam', 'Vaikasi Visakam', 'Adi Krithigai'],
    bookingUrl: 'https://tiruchendurmurugan.hrce.tn.gov.in/',
    darshanInfoUrl: 'https://templedarshantime.com/tiruchendur-murugan-temple/',
    nearbyBus: 'Thiruchendur Bus Stand (0.5 km)',
    nearbyRailway: 'Tiruchendur Railway Station (1 km)',
    travelInfo: const {
      'bus': 'Direct buses from Chennai, Madurai, Tirunelveli, and Tuticorin. Overnight services available.',
      'train': 'Tiruchendur is the terminal station. Direct trains from Chennai Egmore.',
    },
    hotels: const [
      {'name': 'Hotel SR', 'location': 'Thiruchendur', 'distance': '2 km'},
      {'name': 'Chellam Inn', 'location': "Traveller's Bunglow Road", 'distance': '2.4 km'},
      {'name': 'Sri Senthoor Velavan Palace (SSV Palace)', 'location': 'Thiruchendur', 'distance': '2.6 km'},
      {'name': 'Hotel Udhayam International', 'location': "Traveller's Bunglow Road", 'distance': '2.8 km'},
      {'name': 'Pearl Garden Resort', 'location': 'Thiruchendur', 'distance': '6 km'},
      {'name': 'Sundar Residency', 'location': 'Subramaniyapuram Street', 'distance': '3.2 km'},
      {'name': 'GRB Resort', 'location': 'Thiruchendur', 'distance': '2.7 km'},
      {'name': 'Chakravarthi Grand', 'location': "Traveller's Bunglow Road", 'distance': '2.8 km'},
      {'name': 'KSM Muthra Residency', 'location': 'Thiruchendur', 'distance': '2.5 km'},
      {'name': 'VKP Residency', 'location': 'Kovil Street', 'distance': '3 km'},
      {'name': 'Thai Beach Resort', 'location': 'Thiruchendur', 'distance': '2.9 km'},
      {'name': 'Vairavel Grand', 'location': "Traveller's Bunglow Road", 'distance': '2.8 km'},
      {'name': 'Hotel Chendura', 'location': 'Thiruchendur', 'distance': '3.1 km'},
      {'name': 'Hotel Guru Chitra', 'location': "Traveller's Bunglow Road", 'distance': '3.7 km'},
    ],
    restaurants: const ['Hotel Kavery', 'Hotel Ramesh Iyer', 'Sri Senthil Restaurant'],
  ),
];

// ─────────────────────────────────────────────────────────────
//  FESTIVAL DATA
// ─────────────────────────────────────────────────────────────
class FestivalEvent {
  final int notificationId;
  final String name;
  final DateTime date;
  final String temple;
  final String emoji;
  final String description;

  const FestivalEvent({
    required this.notificationId,
    required this.name,
    required this.date,
    required this.temple,
    required this.emoji,
    required this.description,
  });
}

final List<FestivalEvent> festivals = [
  FestivalEvent(
    notificationId: 1001,
    name: 'Thai Poosam',
    date: DateTime(2026, 1, 29, 6, 0),
    temple: 'All Temples',
    emoji: '🪔',
    description: 'Celebrated on the Poosam star in the Tamil month of Thai. Devotees carry kavadi.',
  ),
  FestivalEvent(
    notificationId: 1002,
    name: 'Panguni Uthiram',
    date: DateTime(2026, 3, 17, 6, 0),
    temple: 'All Temples',
    emoji: '🌸',
    description: 'Celebrated in the Tamil month of Panguni on Uthiram star. Divine marriage festival.',
  ),
  FestivalEvent(
    notificationId: 1003,
    name: 'Vaikasi Visakam',
    date: DateTime(2026, 5, 12, 6, 0),
    temple: 'All Temples',
    emoji: '✨',
    description: 'Lord Murugan\'s birthday. Celebrated on Visakam star in Tamil month Vaikasi.',
  ),
  FestivalEvent(
    notificationId: 1004,
    name: 'Aadi Krithigai',
    date: DateTime(2026, 7, 7, 6, 0),
    temple: 'All Temples',
    emoji: '🔱',
    description: 'Celebrated on Krithigai star in the Tamil month of Aadi.',
  ),
  FestivalEvent(
    notificationId: 1005,
    name: 'Skanda Shashti',
    date: DateTime(2026, 10, 22, 6, 0),
    temple: 'All Temples',
    emoji: '⚔️',
    description: 'Six-day festival commemorating Murugan\'s victory over Soorapadman.',
  ),
  FestivalEvent(
    notificationId: 1006,
    name: 'Karthigai Deepam',
    date: DateTime(2026, 11, 30, 6, 0),
    temple: 'All Temples',
    emoji: '🕯️',
    description: 'Festival of lights on Karthigai full moon. Sacred to both Shiva and Murugan.',
  ),
];
