import 'package:flutter/material.dart';

class HPyloriInfo extends StatelessWidget {
  const HPyloriInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H. pylori Info'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/hpylori_1.jpeg'),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is H. pylori?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Helicobacter pylori (H. pylori) is a type of bacteria that can infect your stomach. '
                            'It can cause inflammation and ulcers, and it is also linked to stomach cancer. '
                            'H. pylori is usually contracted during childhood, and it can persist for many years without causing any symptoms.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Symptoms of H. pylori infection',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Although H. pylori infection can be asymptomatic, symptoms may include bloating, abdominal pain, lack of appetite, heartburn, indigestion, nausea, and bleeding.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/hpylori_2.png'),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How is H. pylori infection treated?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'H. pylori infection is usually treated with a combination of antibiotics and acid-suppressing medications. '
                            'The treatment typically lasts for 7 to 14 days. After treatment, your doctor may recommend follow-up testing to ensure that the infection is gone.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/hpylori_3.webp'),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Foods to avoid with peptic ulcer disease',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Peptic ulcer disease is a condition in which sores or ulcers develop in the lining of the stomach or the first part of the small intestine (duodenum). '
                            'Foods that can worsen the symptoms of peptic ulcer disease include pickles, spicy foods, tea, chocolate, carbonated drinks, tomatoes, citrus, french fries, red meat, and coffee.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/hpylori_4.webp'),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PyleraInfo extends StatelessWidget {
  const PyleraInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pylera Info'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/pylera_logo.png'),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is Pylera?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Pylera is a combination of metronidazole, tetracycline, and bismuth subcitrate potassium, '
                            'used in combination with omeprazole to treat patients with Helicobacter pylori infection and duodenal ulcer disease.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How is Pylera used?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Pylera should be taken as prescribed by your doctor. Typically, the medication is taken four times a day with food for 10 days. It\'s important to follow the dosing and timing instructions carefully to ensure the best possible outcome.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/pylera_1.webp'),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Side effects of Pylera',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Some common side effects of Pylera include nausea, vomiting, diarrhea, headache, and abdominal pain. '
                            'Less common side effects include skin rash, fever, and mouth sores. If you experience any side effects, talk to your doctor right away.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/pylera_3.png'),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precautions when taking Pylera',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Before taking Pylera, tell your doctor if you have any allergies or medical conditions, and let them know about any medications you are currently taking. '
                            'Pylera can interact with other medications, so it\'s important to discuss this with your doctor before starting treatment. '
                            'Avoid alcohol while taking Pylera, as it can increase the risk of side effects. ',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/pylera_2.jpeg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
