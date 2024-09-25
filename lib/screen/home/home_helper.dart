part of './view/home_screen.dart';

Column categoriesSection(BuildContext context) {
  // List of categories
  final List<String> categories = [
    'iPhone',
    'Samsung',
    'Huawei',
    'OnePlus',
    'Google Pixel',
    'Xiaomi'
  ];

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
        height: 200,
        child: ListView.builder(
          scrollDirection:
              Axis.horizontal, 
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
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
            );
          },
        ),
      ),
    ],
  );
}


Column phoneList(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
       Text(
        'Phone List',
        style: TextStyle(
          fontSize: 22,
        ),
        
      ),
    ],
  );
}