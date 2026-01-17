class GovernmentScheme {
  final String id;
  final String nameEn;
  final String nameHi;
  final String shortDescEn;
  final String shortDescHi;
  final String aboutEn;
  final String aboutHi;
  final List<String> benefitsEn;
  final List<String> benefitsHi;
  final List<String> documentsEn;
  final List<String> documentsHi;
  final String howToApplyOfflineEn;
  final String howToApplyOfflineHi;
  final String howToApplyOnlineEn;
  final String howToApplyOnlineHi;
  final String officialWebsite;
  final List<String> eligibilityCriteria;
  final String category; // farmer, woman, student, etc.

  GovernmentScheme({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.shortDescEn,
    required this.shortDescHi,
    required this.aboutEn,
    required this.aboutHi,
    required this.benefitsEn,
    required this.benefitsHi,
    required this.documentsEn,
    required this.documentsHi,
    required this.howToApplyOfflineEn,
    required this.howToApplyOfflineHi,
    required this.howToApplyOnlineEn,
    required this.howToApplyOnlineHi,
    required this.officialWebsite,
    required this.eligibilityCriteria,
    required this.category,
  });
}

// Dummy data for government schemes
final List<GovernmentScheme> dummyGovernmentSchemes = [
  GovernmentScheme(
    id: 'pmfby',
    nameEn: 'Pradhan Mantri Fasal Bima Yojana (PMFBY)',
    nameHi: 'प्रधानमंत्री फसल बीमा योजना',
    shortDescEn: 'Crop insurance scheme for farmers',
    shortDescHi: 'किसानों के लिए फसल बीमा योजना',
    aboutEn:
        'The Pradhan Mantri Fasal Bima Yojana (PMFBY) aims to provide insurance coverage and financial support to farmers in the event of failure of any of the notified crop as a result of natural calamities, pests & diseases. It ensures comprehensive risk solution at the lowest uniform premium across the country.',
    aboutHi:
        'प्रधानमंत्री फसल बीमा योजना (PMFBY) का उद्देश्य प्राकृतिक आपदाओं, कीटों और बीमारियों के परिणामस्वरूप अधिसूचित फसलों में से किसी की विफलता की स्थिति में किसानों को बीमा कवरेज और वित्तीय सहायता प्रदान करना है। यह देश भर में सबसे कम समान प्रीमियम पर व्यापक जोखिम समाधान सुनिश्चित करता है।',
    benefitsEn: [
      'Coverage for pre-sowing to post-harvest losses',
      'Low premium rates: 2% for Kharif, 1.5% for Rabi crops',
      'Localized calamities and post-harvest losses covered',
      'Use of technology for quick claim settlement',
      'Protection against natural calamities, pests, and diseases',
    ],
    benefitsHi: [
      'बुवाई से पहले से लेकर कटाई के बाद के नुकसान के लिए कवरेज',
      'कम प्रीमियम दरें: खरीफ के लिए 2%, रबी फसलों के लिए 1.5%',
      'स्थानीय आपदाओं और कटाई के बाद के नुकसान को कवर किया गया',
      'त्वरित दावा निपटान के लिए प्रौद्योगिकी का उपयोग',
      'प्राकृतिक आपदाओं, कीटों और बीमारियों से सुरक्षा',
    ],
    documentsEn: [
      'Aadhaar Card',
      'Bank Account Details',
      'Land Records (Khata/Khasra)',
      'Sowing Certificate (for own land)',
      'Agreement Copy (for tenant farmers)',
      'Photo Identity Proof',
    ],
    documentsHi: [
      'आधार कार्ड',
      'बैंक खाता विवरण',
      'भूमि रिकॉर्ड (खाता/खसरा)',
      'बुवाई प्रमाण पत्र (अपनी भूमि के लिए)',
      'समझौता प्रति (किरायेदार किसानों के लिए)',
      'फोटो पहचान पत्र',
    ],
    howToApplyOfflineEn:
        '1. Visit your nearest Common Service Centre (CSC) or Bank\n2. Submit the filled application form with required documents\n3. Pay the premium amount\n4. Collect acknowledgement receipt\n5. Ensure enrollment before the cut-off date',
    howToApplyOfflineHi:
        '1. अपने निकटतम सामान्य सेवा केंद्र (CSC) या बैंक पर जाएं\n2. आवश्यक दस्तावेजों के साथ भरा हुआ आवेदन पत्र जमा करें\n3. प्रीमियम राशि का भुगतान करें\n4. पावती रसीद एकत्र करें\n5. कट-ऑफ तिथि से पहले नामांकन सुनिश्चित करें',
    howToApplyOnlineEn:
        '1. Visit the official PMFBY portal: pmfby.gov.in\n2. Click on "Farmer Application"\n3. Register with mobile number and Aadhaar\n4. Fill in personal and land details\n5. Upload required documents\n6. Pay premium online\n7. Download acknowledgement',
    howToApplyOnlineHi:
        '1. आधिकारिक PMFBY पोर्टल पर जाएं: pmfby.gov.in\n2. "किसान आवेदन" पर क्लिक करें\n3. मोबाइल नंबर और आधार से पंजीकरण करें\n4. व्यक्तिगत और भूमि विवरण भरें\n5. आवश्यक दस्तावेज अपलोड करें\n6. ऑनलाइन प्रीमियम का भुगतान करें\n7. पावती डाउनलोड करें',
    officialWebsite: 'https://pmfby.gov.in',
    eligibilityCriteria: ['farmer', 'landowner'],
    category: 'farmer',
  ),
  GovernmentScheme(
    id: 'pmkisan',
    nameEn: 'PM-KISAN (Pradhan Mantri Kisan Samman Nidhi)',
    nameHi: 'पीएम-किसान (प्रधानमंत्री किसान सम्मान निधि)',
    shortDescEn: 'Direct income support of ₹6000/year to farmers',
    shortDescHi: 'किसानों को ₹6000/वर्ष की प्रत्यक्ष आय सहायता',
    aboutEn:
        'PM-KISAN is a Central Sector scheme that provides income support to all landholding farmer families in the country. Under the scheme, an amount of ₹6000 per year is released in three equal installments of ₹2000 each directly into the bank accounts of eligible farmer families.',
    aboutHi:
        'पीएम-किसान एक केंद्रीय क्षेत्र की योजना है जो देश में सभी भूमिधारक किसान परिवारों को आय सहायता प्रदान करती है। योजना के तहत, पात्र किसान परिवारों के बैंक खातों में सीधे ₹2000 प्रत्येक की तीन समान किश्तों में प्रति वर्ष ₹6000 की राशि जारी की जाती है।',
    benefitsEn: [
      'Direct cash transfer of ₹6000 per year',
      'Three installments of ₹2000 each',
      'Immediate financial relief to small farmers',
      'No processing fee or intermediary',
      'Automatic transfer to bank account',
    ],
    benefitsHi: [
      'प्रति वर्ष ₹6000 का प्रत्यक्ष नकद हस्तांतरण',
      '₹2000 प्रत्येक की तीन किश्तें',
      'छोटे किसानों को तत्काल वित्तीय राहत',
      'कोई प्रोसेसिंग शुल्क या मध्यस्थ नहीं',
      'बैंक खाते में स्वचालित हस्तांतरण',
    ],
    documentsEn: [
      'Aadhaar Card',
      'Bank Account (with IFSC)',
      'Land Ownership Documents',
      'Mobile Number',
      'Passport Size Photo',
    ],
    documentsHi: [
      'आधार कार्ड',
      'बैंक खाता (IFSC के साथ)',
      'भूमि स्वामित्व दस्तावेज',
      'मोबाइल नंबर',
      'पासपोर्ट साइज फोटो',
    ],
    howToApplyOfflineEn:
        '1. Visit local Patwari/Revenue Officer/Nodal Officer\n2. Fill the registration form\n3. Attach required documents\n4. Submit the form\n5. Collect acknowledgement slip',
    howToApplyOfflineHi:
        '1. स्थानीय पटवारी/राजस्व अधिकारी/नोडल अधिकारी के पास जाएं\n2. पंजीकरण फॉर्म भरें\n3. आवश्यक दस्तावेज संलग्न करें\n4. फॉर्म जमा करें\n5. पावती पर्ची एकत्र करें',
    howToApplyOnlineEn:
        '1. Visit pmkisan.gov.in\n2. Click "Farmers Corner"\n3. Select "New Farmer Registration"\n4. Enter Aadhaar number and mobile\n5. Fill all details and submit\n6. Note registration number',
    howToApplyOnlineHi:
        '1. pmkisan.gov.in पर जाएं\n2. "किसान कोना" पर क्लिक करें\n3. "नया किसान पंजीकरण" चुनें\n4. आधार नंबर और मोबाइल दर्ज करें\n5. सभी विवरण भरें और सबमिट करें\n6. पंजीकरण संख्या नोट करें',
    officialWebsite: 'https://pmkisan.gov.in',
    eligibilityCriteria: ['farmer', 'landowner'],
    category: 'farmer',
  ),
  GovernmentScheme(
    id: 'kkc',
    nameEn: 'Kisan Credit Card (KCC)',
    nameHi: 'किसान क्रेडिट कार्ड (KCC)',
    shortDescEn: 'Short-term credit for agriculture needs',
    shortDescHi: 'कृषि आवश्यकताओं के लिए अल्पकालिक ऋण',
    aboutEn:
        'Kisan Credit Card scheme aims to provide adequate and timely credit support from the banking system to farmers for their cultivation and other needs. The scheme provides flexible and hassle-free credit to farmers at concessional interest rates.',
    aboutHi:
        'किसान क्रेडिट कार्ड योजना का उद्देश्य किसानों को उनकी खेती और अन्य आवश्यकताओं के लिए बैंकिंग प्रणाली से पर्याप्त और समय पर ऋण सहायता प्रदान करना है। यह योजना रियायती ब्याज दरों पर किसानों को लचीला और परेशानी मुक्त ऋण प्रदान करती है।',
    benefitsEn: [
      'Credit limit based on land holding',
      'Low interest rate (4% for timely repayment)',
      'Covers crop cultivation expenses',
      'Post-harvest expenses covered',
      'Cash withdrawal facility',
      'Insurance coverage included',
    ],
    benefitsHi: [
      'भूमि धारण के आधार पर ऋण सीमा',
      'कम ब्याज दर (समय पर पुनर्भुगतान के लिए 4%)',
      'फसल की खेती के खर्च को कवर करता है',
      'कटाई के बाद के खर्च कवर किए गए',
      'नकद निकासी की सुविधा',
      'बीमा कवरेज शामिल',
    ],
    documentsEn: [
      'Identity Proof (Aadhaar/Voter ID)',
      'Address Proof',
      'Land Documents',
      'Photo',
      'Income Proof',
      'Bank Statement',
    ],
    documentsHi: [
      'पहचान प्रमाण (आधार/वोटर आईडी)',
      'पता प्रमाण',
      'भूमि दस्तावेज',
      'फोटो',
      'आय प्रमाण',
      'बैंक विवरण',
    ],
    howToApplyOfflineEn:
        '1. Visit nearest bank branch\n2. Request KCC application form\n3. Fill form with required details\n4. Submit with documents\n5. Wait for verification\n6. Collect card after approval',
    howToApplyOfflineHi:
        '1. निकटतम बैंक शाखा में जाएं\n2. KCC आवेदन फॉर्म का अनुरोध करें\n3. आवश्यक विवरण के साथ फॉर्म भरें\n4. दस्तावेजों के साथ जमा करें\n5. सत्यापन की प्रतीक्षा करें\n6. स्वीकृति के बाद कार्ड एकत्र करें',
    howToApplyOnlineEn:
        '1. Visit bank\'s official website\n2. Navigate to Agriculture/KCC section\n3. Click "Apply Online"\n4. Fill application form\n5. Upload documents\n6. Submit application\n7. Visit branch for verification',
    howToApplyOnlineHi:
        '1. बैंक की आधिकारिक वेबसाइट पर जाएं\n2. कृषि/KCC अनुभाग पर जाएं\n3. "ऑनलाइन आवेदन करें" पर क्लिक करें\n4. आवेदन फॉर्म भरें\n5. दस्तावेज अपलोड करें\n6. आवेदन सबमिट करें\n7. सत्यापन के लिए शाखा में जाएं',
    officialWebsite: 'https://www.nabard.org/content1.aspx?id=489',
    eligibilityCriteria: ['farmer', 'landowner'],
    category: 'farmer',
  ),
  GovernmentScheme(
    id: 'pmay',
    nameEn: 'Pradhan Mantri Awas Yojana (PMAY)',
    nameHi: 'प्रधानमंत्री आवास योजना',
    shortDescEn: 'Housing for all - affordable homes',
    shortDescHi: 'सभी के लिए आवास - किफायती घर',
    aboutEn:
        'Pradhan Mantri Awas Yojana is an initiative by the Government of India to provide affordable housing to the urban poor with a target of building 20 million affordable houses by 31 March 2022. It has two components: Pradhan Mantri Awas Yojana (Urban) for urban poor and Pradhan Mantri Awas Yojana (Gramin) for rural poor.',
    aboutHi:
        'प्रधानमंत्री आवास योजना भारत सरकार की एक पहल है जिसका उद्देश्य शहरी गरीबों को किफायती आवास प्रदान करना है, जिसका लक्ष्य 31 मार्च 2022 तक 20 मिलियन किफायती घर बनाना है। इसके दो घटक हैं: शहरी गरीबों के लिए प्रधानमंत्री आवास योजना (शहरी) और ग्रामीण गरीबों के लिए प्रधानमंत्री आवास योजना (ग्रामीण)।',
    benefitsEn: [
      'Subsidy on home loan interest',
      'Financial assistance up to ₹2.67 lakh',
      'Affordable housing for EWS/LIG/MIG',
      'Women ownership encouraged',
      'Credit linked subsidy scheme',
    ],
    benefitsHi: [
      'होम लोन ब्याज पर सब्सिडी',
      '₹2.67 लाख तक की वित्तीय सहायता',
      'EWS/LIG/MIG के लिए किफायती आवास',
      'महिला स्वामित्व को प्रोत्साहन',
      'क्रेडिट लिंक्ड सब्सिडी योजना',
    ],
    documentsEn: [
      'Aadhaar Card',
      'Income Proof',
      'Property Documents',
      'Bank Account Details',
      'Caste Certificate (if applicable)',
      'Passport Size Photos',
    ],
    documentsHi: [
      'आधार कार्ड',
      'आय प्रमाण',
      'संपत्ति दस्तावेज',
      'बैंक खाता विवरण',
      'जाति प्रमाण पत्र (यदि लागू हो)',
      'पासपोर्ट साइज फोटो',
    ],
    howToApplyOfflineEn:
        '1. Visit CSC or local municipal office\n2. Get application form\n3. Fill with required details\n4. Attach documents\n5. Submit form\n6. Track application status',
    howToApplyOfflineHi:
        '1. CSC या स्थानीय नगरपालिका कार्यालय में जाएं\n2. आवेदन फॉर्म प्राप्त करें\n3. आवश्यक विवरण भरें\n4. दस्तावेज संलग्न करें\n5. फॉर्म जमा करें\n6. आवेदन स्थिति ट्रैक करें',
    howToApplyOnlineEn:
        '1. Visit pmaymis.gov.in\n2. Click "Citizen Assessment"\n3. Select category (Slum/Others)\n4. Enter Aadhaar number\n5. Fill online form\n6. Submit and print acknowledgement',
    howToApplyOnlineHi:
        '1. pmaymis.gov.in पर जाएं\n2. "नागरिक मूल्यांकन" पर क्लिक करें\n3. श्रेणी चुनें (झुग्गी/अन्य)\n4. आधार नंबर दर्ज करें\n5. ऑनलाइन फॉर्म भरें\n6. सबमिट करें और पावती प्रिंट करें',
    officialWebsite: 'https://pmaymis.gov.in',
    eligibilityCriteria: ['lowincome'],
    category: 'housing',
  ),
  GovernmentScheme(
    id: 'ays',
    nameEn: 'Atal Pension Yojana (APY)',
    nameHi: 'अटल पेंशन योजना',
    shortDescEn: 'Pension scheme for unorganized sector',
    shortDescHi: 'असंगठित क्षेत्र के लिए पेंशन योजना',
    aboutEn:
        'Atal Pension Yojana (APY) is a pension scheme for citizens of India focused on the unorganized sector workers. The subscribers will receive a guaranteed minimum pension of ₹1,000 to ₹5,000 per month from the age of 60 years, depending on their contribution.',
    aboutHi:
        'अटल पेंशन योजना (APY) भारत के नागरिकों के लिए एक पेंशन योजना है जो असंगठित क्षेत्र के श्रमिकों पर केंद्रित है। ग्राहकों को 60 वर्ष की आयु से उनके योगदान के आधार पर प्रति माह ₹1,000 से ₹5,000 की गारंटीकृत न्यूनतम पेंशन प्राप्त होगी।',
    benefitsEn: [
      'Guaranteed pension of ₹1000-5000/month',
      'Government co-contribution for eligible subscribers',
      'Pension amount to spouse after subscriber\'s death',
      'Return of corpus to nominee',
      'Tax benefits under Section 80CCD',
    ],
    benefitsHi: [
      '₹1000-5000/माह की गारंटीकृत पेंशन',
      'पात्र ग्राहकों के लिए सरकारी सह-योगदान',
      'ग्राहक की मृत्यु के बाद जीवनसाथी को पेंशन राशि',
      'नामांकित व्यक्ति को कोष की वापसी',
      'धारा 80CCD के तहत कर लाभ',
    ],
    documentsEn: [
      'Aadhaar Card',
      'Bank Account (Savings)',
      'Mobile Number',
      'Age Proof',
      'Nominee Details',
    ],
    documentsHi: [
      'आधार कार्ड',
      'बैंक खाता (बचत)',
      'मोबाइल नंबर',
      'आयु प्रमाण',
      'नामांकित व्यक्ति का विवरण',
    ],
    howToApplyOfflineEn:
        '1. Visit your bank branch\n2. Request APY enrollment form\n3. Fill the form completely\n4. Submit with required documents\n5. Activate auto-debit facility\n6. Receive acknowledgement',
    howToApplyOfflineHi:
        '1. अपनी बैंक शाखा में जाएं\n2. APY नामांकन फॉर्म का अनुरोध करें\n3. फॉर्म पूर्ण रूप से भरें\n4. आवश्यक दस्तावेजों के साथ जमा करें\n5. ऑटो-डेबिट सुविधा सक्रिय करें\n6. पावती प्राप्त करें',
    howToApplyOnlineEn:
        '1. Login to your net banking\n2. Go to Investments/Pension section\n3. Select "Atal Pension Yojana"\n4. Fill registration form\n5. Choose pension amount\n6. Enable auto-debit\n7. Submit application',
    howToApplyOnlineHi:
        '1. अपने नेट बैंकिंग में लॉगिन करें\n2. निवेश/पेंशन अनुभाग पर जाएं\n3. "अटल पेंशन योजना" चुनें\n4. पंजीकरण फॉर्म भरें\n5. पेंशन राशि चुनें\n6. ऑटो-डेबिट सक्षम करें\n7. आवेदन सबमिट करें',
    officialWebsite: 'https://www.npscra.nsdl.co.in/atal-pension-yojana.php',
    eligibilityCriteria: [],
    category: 'pension',
  ),
];
