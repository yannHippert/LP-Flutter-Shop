import 'package:uuid/uuid.dart';

const uuid = Uuid();

const red = {"name": "Red", "r": 255, "g": 0, "b": 0};
const green = {"name": "Green", "r": 0, "g": 255, "b": 0};
const blue = {"name": "Blue", "r": 0, "g": 0, "b": 255};
const dblue = {"name": "DBlue", "r": 0, "g": 0, "b": 125};
const yellow = {"name": "Yellow", "r": 255, "g": 255, "b": 0};
const pink = {"name": "Pink", "r": 255, "g": 50, "b": 175};
const black = {"name": "Black", "r": 0, "g": 0, "b": 0};
const grey = {"name": "Grey", "r": 110, "g": 110, "b": 110};
const beige = {"name": "Beige", "r": 245, "g": 200, "b": 240};
const white = {"name": "White", "r": 255, "g": 255, "b": 255};

final hats = [
  {
    "id": uuid.v4(),
    "name": "iParaAiluRy Slouch Beanie Men's Hat",
    "url":
        "https://www.amazon.de/-/en/iParaAiluRy-Slouch-Beanie-Winter-Autumn/dp/B0B7PKTJ2Z/ref=sr_1_25?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-25&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 10.99,
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 11.99,
        "color": grey,
      },
    ],
    "description":
        "- One size and unisex: men's beanie. The unisex and one size models all fit a head circumference of 22 to 24 inches and combine a lot of stretch with a comfortable fit. With a head circumference of less than 22 inches, it will be a little slouch.- High-quality materials: men's beanie made of high-quality materials acrylic and polyester. The two-layer design makes the outer material uniquely breathable and does not feel stuffy when worn. The lining gives you extra warmth. Light and soft, absorbs sweat and protects the skin.- Closure: Toggle- Knitted- Beanie",
    "image": "https://m.media-amazon.com/images/I/71fBPLtlQKL._AC_UL1500_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "Durio Winter Hat Warm Beanie Hat",
    "url":
        "https://www.amazon.de/-/en/Winter-Beanie-Knitted-Design-Modern/dp/B0BMPW5HYD/ref=cs_sr_dp_3?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-28",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 13.99,
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 13.99,
        "color": blue,
      },
      {
        "id": uuid.v4(),
        "price": 13.99,
        "color": green,
      },
      {
        "id": uuid.v4(),
        "price": 13.99,
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 13.99,
        "color": black,
      },
    ],
    "description":
        "- STRETCHY AND SOFT: The stretchy rib knit that feels soft against the skin is moderately stretchable, but does not lose its elasticity even after washing. This advantage ensures that the knitted hat does not slip off the head, regardless of shape and size.- Super warm: hats for adults provide warmth and comfort for men and women, and in winter your ears will never feel cold. The super soft knitted hat ensures a comfortable fit while being breathable enough to keep you warm.- Closure: Pull-On- 100% Polyacryl- Beanie- Model: DUDD4793DL01007",
    "image": "https://m.media-amazon.com/images/I/71LO-VsDPdL._AC_UL1500_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "styleBREAKER Slouch, unisex classic",
    "url":
        "https://www.amazon.de/-/en/styleBREAKER-Slouch-unisex-classic-04024018/dp/B00UZ76EOE/ref=cs_sr_dp_4?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-29&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 15.95,
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 15.95,
        "color": red,
      },
      {
        "id": uuid.v4(),
        "price": 15.95,
        "color": blue,
      },
      {
        "id": uuid.v4(),
        "price": 16.45,
        "color": dblue,
      },
      {
        "id": uuid.v4(),
        "price": 16.45,
        "color": black,
      },
    ],
    "description":
        "- Great wearing comfort thanks to the stretch component.- Soft, comfortable material.- Closure: Ohne Verschluss- 65% Baumwolle, 35% Polyester- Beanie- Model: 4024018- Waist band: approx. 26 cm (stretch), one size for adults.",
    "image": "https://m.media-amazon.com/images/I/61vG6jfGyUL._AC_UL1500_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "Beechfield, Unisex Vintage Double Knit Beanie Hat",
    "url":
        "https://www.amazon.de/-/en/Beechfield-Unisex-Vintage-Double-Beanie/dp/B076SYLR74/ref=cs_sr_dp_6?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-50",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 20.99,
        "color": red,
      },
      {
        "id": uuid.v4(),
        "price": 20.99,
        "color": dblue,
      },
    ],
    "description":
        "- Double layer knit- Cuffed design- Long Sleeve- 100% Polyacryl- Beanie- Model: 144486",
    "image": "https://m.media-amazon.com/images/I/71RPcLJespL._AC_UL1181_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "Eono Knitted Unisex Hat",
    "url":
        "https://www.amazon.de/Eono-Amazon-Unisex-Winter-Knitted/dp/B07YWD2928/ref=sr_1_1_sspa?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 9.98,
        "color": black,
      },
    ],
    "description":
        "- ✔ Premium soft acrylic. Slouchy hat for men and women from Eono is made of premium soft and stretchy fibre. Extremely comfortable and soft, it can wrap around your head, including the ears, and will not move. As a winter hat, it is also great at trapping heat, which can provide great heat retention.- 100 % Polyacrylic- Beanie- ✔ One size fits all. Unisex warm hat from Eono can stretch up to 51 cm, will fit most people and different head shapes, whether small or large.- ✔ Wide range of uses. This knitted hat is a perfect athleisure piece for parties, school, sports and outdoor activities such as skiing, skateboarding, snowboarding, fishing, hiking and camping.- ✔ Stylish & valuable gift. Precisely knitted, cuffed, plain hat, creating a beautiful and fashionable look, easy to pair with cardigans, scarves, leggings or other formal and casual outfits. Practical gifts for families and friends.",
    "image": "https://m.media-amazon.com/images/I/61Y3K5dcG7L._AC_UL1200_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "urban ace | Street Classics | Beanie",
    "url":
        "https://www.amazon.de/Street-Classics-Beanie-Leather-Seasons/dp/B00RBNN8FI/ref=sr_1_3_sspa?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-3-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 14.95,
        "color": red,
      },
      {
        "id": uuid.v4(),
        "price": 14.95,
        "color": black,
      },
    ],
    "description":
        "- The Urban Ace leather patch on the cuff is subtle and stylish at the same time. In combination with the high-quality workmanship, it creates a cool street look. No loose seams or threads.- This beanie will keep you warm and covers your ears to keep you protected from the wind. Nevertheless, you won't sweat even after prolonged wear.- Closure: Pull on. Loose fit yet non-slip - a perfect fit for any head size.- 100% Polyacryl- Beanie- Model: UA43853- Loose fit yet non-slip - an ideal fit for any head size.",
    "image": "https://m.media-amazon.com/images/I/81sunkRWGOL._AC_UL1500_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "Occulto Leather Patch Winter Beanie",
    "url":
        "https://www.amazon.de/Street-Classics-Beanie-Leather-Seasons/dp/B00RBNN8FI/ref=sr_1_3_sspa?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-3-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 12.99,
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 13.99,
        "color": dblue,
      },
      {
        "id": uuid.v4(),
        "price": 14.99,
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 14.99,
        "color": red,
      },
    ],
    "description":
        "- Highly comfortable: The winter beanie hat is very comfortable to wear, thanks to the carefully selected fabric.- Trendy and modern beanie: The beanie can be worn all year round. It doesn’t matter whether you're skiing or on a leisurely walk.- Closure: Pull-on- 100% Polyacryl- Beanie- Model: Beanie1,4- Perfect fit: Thanks to the stretchy ribbed material, the winter beanie hat adapts perfectly to the shape of your head without any annoying slipping.",
    "image": "https://m.media-amazon.com/images/I/710II-e+IaL._AC_UL1400_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "Carhartt Workwear Beanie Watch Hat",
    "url":
        "https://www.amazon.de/-/en/Carhartt-Mens-Watch-Beanie-Einheitsgr%C3%B6%C3%9Fe/dp/B002G64PJS/ref=cs_sr_dp_4?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-8",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 89.28,
        "color": blue,
      },
    ],
    "description":
        "- Carhartt label on the front- 100% acrylic- 100% Polyacryl- Beanie- Model: A18- Stretchable- Hand wash only- Made in the USA from imported materials",
    "image": "https://m.media-amazon.com/images/I/91zQksN7lHL._AC_UL1500_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "Balinco Beanie Hat (Unisex)",
    "url":
        "https://www.amazon.de/-/en/Jersey-Cotton-Elastic-Slouch-Heather/dp/B06XRQG4KM/ref=cs_sr_dp_6?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-6",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 12.90,
        "color": green,
      },
      {
        "id": uuid.v4(),
        "price": 12.90,
        "color": blue,
      },
      {
        "id": uuid.v4(),
        "price": 12.90,
        "color": dblue,
      },
      {
        "id": uuid.v4(),
        "price": 12.90,
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 13.90,
        "color": red,
      },
    ],
    "description":
        "- ✅Very soft, comfortable to wear material available in 35 different colours (dark grey, light grey, red, blue, dark blue, dark brown, brown, mint, heather, yellow, purple, black, grey, white, green, dark green, denim blue, orange).- ✅ Beanies for autumn, winter and spring.- 100% Cotton- Beanie- ✅Adult’s classic long beanie in one size (One size/unisex: Headband width: approx. 25 cm and length approx. 28 cm. For both measurements, please note that the hat can stretch and is therefore suitable for any head size. Shape: Classic long slouch beanie. When pulled up it folds over the back of the head, creating a loose slouch look.- ✅ This knitted beanie is made of stretch material so it stays in place well and is comfortable to wear.- ✅ Care instructions: machine washable at 30°C/gentle wash.",
    "image": "https://m.media-amazon.com/images/I/61ycb08k+rL._AC_UL1000_.jpg",
    "category": "hat"
  },
  {
    "id": uuid.v4(),
    "name": "Carhartt Beanie Hat",
    "url":
        "https://www.amazon.de/-/en/Carhartt-Acrylic-Beanie-Mtze-Slate-Green/dp/B09KTCFV5C/ref=cs_sr_dp_5?crid=2YBFNDOS5L9KI&keywords=beanie&qid=1678206062&sprefix=beanie%2Caps%2C88&sr=8-13",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 16.45,
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 16.95,
        "color": blue,
      },
      {
        "id": uuid.v4(),
        "price": 16.95,
        "color": dblue,
      },
    ],
    "description":
        "- Rib knit- Label on the front- Polyacrylic- Beanie- Model: 101070- Unisex- One size",
    "image": "https://m.media-amazon.com/images/I/71ASb0r+PRL._AC_UL1000_.jpg",
    "category": "hat"
  },
];
