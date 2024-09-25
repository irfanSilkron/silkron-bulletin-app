part of './view/home_screen.dart';

final List<String> categories = [
  'Apple',
  'Samsung',
  'Huawei',
  'OnePlus',
  'Google Pixel',
  'Xiaomi'
];

Column categoriesSection(BuildContext context) {
  // List of categories

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 20,
      ),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Phone Brands',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Icon(
                          Icons.phone_android,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      categories[index],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget phoneListSection(BuildContext context) {
  final List<Map<String, String>> phones = [
    {'brand': 'iPhone', 'model': 'iPhone 16'},
    {'brand': 'iPhone', 'model': 'iPhone XR'},
    {'brand': 'Samsung', 'model': 'Samsung Galaxy S24'},
    {'brand': 'Samsung', 'model': 'Samsung Galaxy Note 21'},
    {'brand': 'Huawei', 'model': 'Huawei P50'},
    {'brand': 'OnePlus', 'model': 'OnePlus 9 Pro'},
  ];

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Phone List',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(6, (index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.phone_android,
                    ),
                    Text(
                      categories[index],
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}
