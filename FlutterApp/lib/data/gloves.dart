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

final gloves = [
  {
    "id": uuid.v4(),
    "name": "LOVARZI Women's Wool Gloves",
    "url":
        "https://www.amazon.de/-/en/Ladies-Gloves-Black-Lovarzi-Unisex/dp/B00FN6QSX4/ref=cs_sr_dp_3?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-22&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 14.99,
        "size": {"name": "S"},
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 14.99,
        "size": {"name": "M"},
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 14.99,
        "size": {"name": "L"},
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 15.99,
        "size": {"name": "S"},
        "color": red
      },
      {
        "id": uuid.v4(),
        "price": 15.99,
        "size": {"name": "L"},
        "color": red
      }
    ],
    "description": "- Pure lambswool gloves- Soft & Warm- 100% Wool",
    "image": "https://m.media-amazon.com/images/I/71AeoJO9tHL._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Pure Mongolian Wool Fingerless Gloves",
    "url":
        "https://www.amazon.de/-/en/Mongolian-Fingerless-Gloves-Mittens-lightgrey/dp/B07B295RPX/ref=sr_1_21?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-21&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "S"},
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "M"},
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "L"},
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "S"},
        "color": red
      },
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "L"},
        "color": red
      }
    ],
    "description":
        "- Thick pure wool gloves.- They are very convenient for driving, writing and making calls.- Suitable for both men and women.- Fingerless.",
    "image": "https://m.media-amazon.com/images/I/8167wFxlqdL._AC_SL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Barts Herren Haakon Glove",
    "url":
        "https://www.amazon.de/-/en/Barts-Mens-Haakon-Gloves-Glove/dp/B07R5G3YTJ/ref=sr_1_28?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-28&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "S"},
        "color": grey,
      },
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "M"},
        "color": grey,
      },
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "M"},
        "color": beige,
      },
      {
        "id": uuid.v4(),
        "price": 19.88,
        "size": {"name": "M"},
        "color": black,
      },
    ],
    "description":
        "- Closure: Ohne Verschluss- 100% cotton- gloves- Model: 15-0000000095- Material: 95% wool, untreated, 5% polyester.",
    "image": "https://m.media-amazon.com/images/I/8167wFxlqdL._AC_SL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Levi's Men's Ben Touch Screen Gloves",
    "url":
        "https://www.amazon.de/-/en/Levis-Touch-Screen-Gloves-Black/dp/B00J2SFLDM/ref=sr_1_29?crid=QF55ST17I17C&keywords=handschuhe+wolle&qid=1678191630&sprefix=gloves+wool%2Caps%2C77&sr=8-29",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 22.22,
        "size": {"name": "M"},
        "color": black,
      },
      {
        "id": uuid.v4(),
        "price": 22.22,
        "size": {"name": "L"},
        "color": black,
      },
    ],
    "description":
        "- Brand: Levi´s- Winter gloves, women’s finger gloves, men’s gloves, knitted, finger gloves- 96% polyacrylic, 3% cotton, 1% metal.- Handschuhe- Model: 222283-11- The practical gloves from the cult brand Levi's are made in Italy and offer not only optimal protection against the cold. Fine metal threads are incorporated into the fingertips of the winter gloves, which allow you to operate the smartphone without having to remove the gloves",
    "image": "https://m.media-amazon.com/images/I/816rnEhkKBL._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "BINXWA Unisex Winter Warm Gloves",
    "url":
        "https://www.amazon.de/Windproof-Thickened-Elastic-Suitable-Outdoors/dp/B09FSW1GNX/ref=sr_1_33_sspa?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-33-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9tdGY&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 9.99,
        "size": {"name": "M"},
        "color": grey,
      },
      {
        "id": uuid.v4(),
        "price": 9.99,
        "size": {"name": "S"},
        "color": grey,
      },
      {
        "id": uuid.v4(),
        "price": 9.99,
        "size": {"name": "L"},
        "color": grey,
      },
    ],
    "description":
        "- Touchscreen glove: suitable for touch devices such as smartphones, tablets, cameras etc- Winter gloves: 50% wool, 45% acrylic, 5% elastane, elastic cuffs, wind and snow proof- Size: length: winter gloves 23 cm, width: 10 cm, made of elastic material, unisex, suitable for most people- Applicable occasions: thermal gloves. Suitable for various outdoor activities such as cycling, running and working. The wool material protects your hands from the cold- GIFTS: These wool gloves are unisex. You can give it as a birthday or Christmas gift to family or friends without worrying about their size. You will like it very much",
    "image": "https://m.media-amazon.com/images/I/71yuGlWyRCL._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Celavi Unisex Magic Gloves",
    "url":
        "https://www.amazon.de/-/en/Celavi-Unisex-Gloves-Finger-Bright/dp/B098JYW5V5/ref=sr_1_41?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-41&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 16.50,
        "size": {"name": "XS"},
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 16.50,
        "size": {"name": "S"},
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 16.50,
        "size": {"name": "M"},
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 17.50,
        "size": {"name": "XS"},
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 17.50,
        "size": {"name": "S"},
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 17.50,
        "size": {"name": "M"},
        "color": pink,
      },
    ],
    "description":
        "- The gloves from the Danish brand CeLaVi are the perfect companion for active children on cold days.- Thanks to the high-quality wool, the gloves are cuddly soft and do not scratch. The nylon and elastane content ensures high elasticity and dimensional stability. Available in 2 sizes for children aged 3-6 years and 7-12 years.- Closure: Pull On- Full-Finger- Model: 5670- Contains 2 pairs",
    "image": "https://m.media-amazon.com/images/I/81E6R5Ox6oL._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "EEM Ladies Knitted Gloves",
    "url":
        "https://www.amazon.de/-/en/Knitted-ThinsulateTM-Thermal-Material-Dependent/dp/B00NIWS5RW/ref=cs_sr_dp_4?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-48&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 21.45,
        "size": {"name": "S"},
        "color": blue,
      },
      {
        "id": uuid.v4(),
        "price": 21.45,
        "size": {"name": "M"},
        "color": blue,
      },
      {
        "id": uuid.v4(),
        "price": 21.95,
        "size": {"name": "S"},
        "color": red,
      },
      {
        "id": uuid.v4(),
        "price": 21.95,
        "size": {"name": "M"},
        "color": red,
      },
      {
        "id": uuid.v4(),
        "price": 21.95,
        "size": {"name": "L"},
        "color": red,
      },
    ],
    "description":
        "- Classic knitted gloves made from 100% wool or 100% cotton, also available with touch function.- 3M Thinsulate, breathable, water-repellent, best thermal insulation.- Outer material 100% wool- Model: 2817L-ANS- The soft thermal fleece lining does not scratch the skin.- Many different sizes offer the perfect fit for any hand.",
    "image": "https://m.media-amazon.com/images/I/91dn0yqkBdL._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Playshoes Kids’ Unisex Winter Gloves",
    "url":
        "https://www.amazon.de/-/en/Knitted-ThinsulateTM-Thermal-Material-Dependent/dp/B00NIWS5RW/ref=cs_sr_dp_4?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-48&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 12.95,
        "size": {"name": "S"},
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 12.95,
        "size": {"name": "M"},
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 13.95,
        "size": {"name": "S"},
        "color": dblue,
      },
      {
        "id": uuid.v4(),
        "price": 12.95,
        "size": {"name": "M"},
        "color": dblue,
      },
    ],
    "description":
        "- Prepared for winter: our warm unisex children's finger gloves offer girls and boys ideal protection on cold days. For older children, the finger gloves are a fine alternative, as they can easily grip and thus perform all activities- The gloves can be easily put on and taken off thanks to the elastic soft cuffs. In addition, the cuffs ensure a perfect hold of the children's gloves- Closure: Elastisch- 100% Polyester- Leisure nursery school- Model: 422049_11_2- Thanks to a hook and eyelet, the warming gloves can be easily hung together after wearing",
    "image": "https://m.media-amazon.com/images/I/910uML8rziL._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Celavi Unisex Baby Magic Mittens",
    "url":
        "https://www.amazon.de/-/en/Celavi-Unisex-Mittens-Bright-Cobalt/dp/B098JYJTHX/ref=sr_1_54?crid=QF55ST17I17C&keywords=handschuhe%2Bwolle&qid=1678191630&sprefix=gloves%2Bwool%2Caps%2C77&sr=8-54&th=1",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 16.50,
        "size": {"name": "XS"},
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 16.95,
        "size": {"name": "S"},
        "color": yellow,
      },
      {
        "id": uuid.v4(),
        "price": 16.50,
        "size": {"name": "XS"},
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 16.95,
        "size": {"name": "S"},
        "color": pink,
      },
      {
        "id": uuid.v4(),
        "price": 16.50,
        "size": {"name": "XS"},
        "color": blue,
      },
      {
        "id": uuid.v4(),
        "price": 16.95,
        "size": {"name": "S"},
        "color": blue,
      },
    ],
    "description":
        "- The gloves from the Danish brand CeLaVi are the perfect companion for active children on cold days.- Thanks to the high-quality wool, the mittens are cuddly soft and do not scratch. The nylon and elastane content ensures high elasticity and dimensional stability. Available in 2 sizes for children aged 1-2 years and 3-6 years.- Closure: Pull On- Fingerless- Model: 5669- Contains 2 pairs    ",
    "image": "https://m.media-amazon.com/images/I/81Ek8Z66K3L._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Homealexa Gloves",
    "url":
        "https://www.amazon.de/-/en/Touchscreen-Knitted-Windproof-Cycling-Suitable/dp/B07Y7S6GPT/ref=sr_1_6?crid=QF55ST17I17C&keywords=handschuhe+wolle&qid=1678191630&sprefix=gloves+wool%2Caps%2C77&sr=8-6",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 8.99,
        "size": {"name": "S"},
      },
      {
        "id": uuid.v4(),
        "price": 8.99,
        "size": {"name": "M"},
      },
      {
        "id": uuid.v4(),
        "price": 8.99,
        "size": {"name": "L"},
      },
      {
        "id": uuid.v4(),
        "price": 8.99,
        "size": {"name": "Xl"},
      },
    ],
    "description":
        "- Sensitive touch: With touch-conductive fabric at the three finger tips, so that touchscreen devices such as smartphones, iPads, tablets, vehicle GPS systems and much more can be easily operated without having to take off your gloves. It is good to not have ice cold fingers while writing in cold winter.- Multifunctional and warmer gloves: These new version touchscreen gloves are made of 80% alpaca and 20% polyester - thick enough to keep your hands warm when you are driving, running, cycling, hiking, etc., but thin in your coat pocket or purse without problems.- Classic grau- Model: DZ70- Cosy fit and super comfort: The elastic material ensures that the touch screen winter gloves fit comfortably on your hands to ensure a perfect fit. You can bend your fingers freely, so you can move freely.",
    "image": "https://m.media-amazon.com/images/I/71G8t-M2cYL._AC_UL1500_.jpg",
    "category": "gloves"
  },
  {
    "id": uuid.v4(),
    "name": "Bequemer Laden Ladies Winter Warm Gloves",
    "url":
        "https://www.amazon.de/-/en/Bequemer-Stretched-Cashmere-Stretch-Knitted/dp/B07XQ4GXMG/ref=cs_sr_dp_5?crid=QF55ST17I17C&keywords=handschuhe+wolle&qid=1678191630&sprefix=gloves+wool%2Caps%2C77&sr=8-8",
    "variants": [
      {
        "id": uuid.v4(),
        "price": 14.99,
        "color": yellow,
        "size": {"name": "M"},
      },
      {
        "id": uuid.v4(),
        "price": 14.99,
        "color": yellow,
        "size": {"name": "L"},
      },
      {
        "id": uuid.v4(),
        "price": 15.99,
        "color": dblue,
        "size": {"name": "Xl"},
      },
    ],
    "description":
        "- Warm material: 100% acrylic and wool blend lining; One size fits most. Soft, comfortable and warm wool lining ensures that your hands feel warm. Simple fashion, stylish and durable.- Windproof cuff: The elasticated cuff of the gloves made from a cashmere knitted blend protects against wind and snow and keeps you warm in autumn and winter. Hand wash or spot cleaning recommended. Please do not wash in the machine or with the brush.- 100% Acryl und Wollmischung Futter- Touch Screen Function: The fleece gloves equipped with a touchscreen function allow you to work with thumb, index finger and middle finger on all touchscreen devices. Use touch screens with gloves, smartphones, Tablet and PCs, etc.",
    "image": "https://m.media-amazon.com/images/I/81zv8E6CWYL._AC_UL1500_.jpg",
    "category": "gloves"
  },
];
