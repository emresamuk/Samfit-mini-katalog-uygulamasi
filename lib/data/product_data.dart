part of '../main.dart';

const products = <Product>[
  Product(
    id: 1,
    name: 'Nike Pegasus 40',
    category: 'Koşu',
    description:
        'Hafif köpük taban ve nefes alan üst yüzey ile günlük koşular için konforlu performans.',
    price: 3299,
    color: Color(0xFFE7EEF4),
    icon: Icons.directions_run_rounded,
    imageUrl:
        'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto%2Cq_auto%3Aeco%2Cc_scale%2Cw_700%2Ch_700%2Cc_pad/bc26760f-9fd1-456b-9e60-47def7cec2d6/AIR%2BZOOM%2BPEGASUS%2B40.png',
    isPopular: true,
  ),
  Product(
    id: 2,
    name: 'adidas Dame 8 EXTPLY',
    category: 'Basketbol',
    description:
        'Sahada hızlı yön değişimleri ve sıçramalar için dengeli bilek desteği.',
    price: 3899,
    color: Color(0xFFF1E5DC),
    icon: Icons.sports_basketball_rounded,
    imageUrl:
        'https://images.novelship.com/product/adidas_dame_8__admit_one___cloud_white__gy6462_0_38517.jpeg?auto=compress&bg=FFFFFF&fit=fill&fm=webp&h=1200&pad=80&q=75&trim=color&w=1200',
    isPopular: true,
  ),
  Product(
    id: 3,
    name: 'Fenerbahçe Futbol Antrenman Forması',
    category: 'Forma',
    description:
        'Antrenman ve maç günleri için hafif, hızlı kuruyan ve esnek kumaş.',
    price: 3199,
    color: Color(0xFFE3EAF5),
    icon: Icons.checkroom_rounded,
    imageUrl:
        'https://images.unsplash.com/photo-1517466787929-bc90951d0974?auto=format&fit=crop&w=900&q=80',
    isPopular: true,
  ),
  Product(
    id: 4,
    name: 'Manduka PROlite Mat',
    category: 'Yoga',
    description:
        'Duruşunu destekleyen kaymaz yüzey ve kolay taşınan hafif tasarım.',
    price: 899,
    color: Color(0xFFE5F0E8),
    icon: Icons.self_improvement_rounded,
    imageUrl:
        'https://manduka.com.au/cdn/shop/files/112011153-PL71-MALDIVE-01_9f0d6fdb-9f18-49a5-a07a-c779c7b70eda.jpg?v=1767759797&width=1000',
  ),
  Product(
    id: 5,
    name: 'Döküm Kettlebell',
    category: 'Fitness',
    description:
        'Fonksiyonel kuvvet ve dayanıklılık antrenmanları için profesyonel döküm kettlebell.',
    price: 1499,
    color: Color(0xFFEDE8E3),
    icon: Icons.fitness_center_rounded,
    imageUrl:
        'https://www.gymholix.com/idea/ba/41/myassets/products/411/5-1.jpg?revision=1792385950',
  ),
  Product(
    id: 6,
    name: 'Spor Sırt Çantası',
    category: 'Aksesuar',
    description:
        'Spor salonu ve açık hava aktiviteleri için geniş, sağlam ve kullanışlı çanta.',
    price: 1799,
    color: Color(0xFFE9E8E3),
    icon: Icons.backpack_rounded,
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=80',
  ),
  Product(
    id: 7,
    name: 'On Cloudflow 5',
    category: 'Koşu',
    description:
        'Hafif yapısı ve enerjik taban teknolojisiyle tempo koşuları için tasarlanan On Cloudflow 5.',
    price: 6799,
    color: Color(0xFFF0E7E0),
    icon: Icons.directions_run_rounded,
    imageUrl:
        'https://images.unsplash.com/photo-1637437757614-6491c8e915b5?auto=format&fit=crop&w=900&q=80',
  ),
  Product(
    id: 8,
    name: 'adidas Dame 8 Turkuaz',
    category: 'Basketbol',
    description:
        'Sokak basketbolu için kavrama gücü yüksek kauçuk taban ve rahat bilek yapısı.',
    price: 4499,
    color: Color(0xFFE6EDF5),
    icon: Icons.sports_basketball_rounded,
    imageUrl:
        'https://www.sportvision.rs/files/images/slike_proizvoda/media/GZ6/GZ6475/images/GZ6475_2.jpg',
  ),
  Product(
    id: 9,
    name: 'Hummel Milli Takım Antrenman Tişörtü',
    category: 'Forma',
    description:
        'Yoğun antrenmanlarda ferahlık sağlayan hızlı kuruyan spor forması.',
    price: 1999,
    color: Color(0xFFE9E5F1),
    icon: Icons.checkroom_rounded,
    imageUrl:
        'https://www.crsspor.com/idea/li/08/myassets/products/953/1.jpg?revision=1777983058',
  ),
  Product(
    id: 10,
    name: 'Kırmızı Yoga Matı',
    category: 'Yoga',
    description:
        'Doğal mantar yüzeyli, dengeli tutuş sağlayan premium yoga matı.',
    price: 1199,
    color: Color(0xFFEDE8DF),
    icon: Icons.self_improvement_rounded,
    imageUrl:
        'https://cdn.shopify.com/s/files/1/1370/7211/products/unnamed_22284cf1-e1c3-4517-8d90-448a221bf325_1800x1800.jpg?v=1578394315',
  ),
  Product(
    id: 11,
    name: 'Rubber Dumbell Set 390KG',
    category: 'Fitness',
    description:
        'Fonksiyonel antrenmanlar için sağlam gövde ve güvenli geniş tutma alanı.',
    price: 18999,
    color: Color(0xFFE7E7E5),
    icon: Icons.fitness_center_rounded,
    imageUrl:
        'https://www.novasport.com.tr/dashboard/uploads/Dumbell_set_105.png',
  ),
  Product(
    id: 12,
    name: 'Hydro Flask 24 oz Matarası',
    category: 'Aksesuar',
    description:
        'Antrenman boyunca suyu yanında taşıman için sızdırmaz spor matarası.',
    price: 549,
    color: Color(0xFFE1EEF1),
    icon: Icons.water_drop_rounded,
    imageUrl:
        'https://i5.samsclubimages.com/asr/4720bd63-f8cb-43d2-b2a0-e2cc7887ad3b.901800737998a8f345ccf78bdb239d3a.jpeg',
  ),
];
