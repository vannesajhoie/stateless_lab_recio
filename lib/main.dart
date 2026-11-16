import 'package:flutter/material.dart';

void main() => runApp(const DirectoryApp());

// ---------------- DATA MODEL ----------------
class Student {
  final String name;
  final String course;
  final int yearLevel;
  final String email;

  const Student({
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.email,
  });
}

// Hard-coded list of students (at least 5)
const List<Student> students = [
  Student(
    name: 'Henry James Abis',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'henry.james@school.edu',
  ),
  Student(
    name: 'Joseph Denver Chavez',
    course: 'BS Computer Science',
    yearLevel: 2,
    email: 'joseph.chavez@school.edu',
  ),
  Student(
    name: 'Via Escobido',
    course: 'BS Information Systems',
    yearLevel: 4,
    email: 'via.escobido@school.edu',
  ),
  Student(
    name: 'Vannesa Recio',
    course: 'BS Computer Engineering',
    yearLevel: 1,
    email: 'vannesa.recio@school.edu',
  ),
  Student(
    name: 'Djemnah Bagtasos',
    course: 'BS Information Technology',
    yearLevel: 2,
    email: 'djemnah.bagtasos@school.edu',
  ),
];

// ---------------- APP ----------------
// Stateless: it only builds MaterialApp from fixed values and holds no changing data.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Directory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal, // CUSTOMIZATION 1: theme seed color
        useMaterial3: true,
      ),
      home: const DirectoryScreen(),
    );
  }
}

// ---------------- SCREEN ----------------
// Stateless: the screen just displays the hard-coded list; nothing on it changes by itself.
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Directory'),
        backgroundColor: colors.primary, // colored AppBar
        foregroundColor: colors.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12), // CUSTOMIZATION 2: list padding
        children: [
          const SectionHeader(title: 'Students'),
          for (final student in students) StudentCard(student: student),
        ],
      ),
    );
  }
}

// ---------------- SECTION HEADER ----------------
// Stateless: its title is passed in through the constructor and never changes inside the widget.
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold, // bold heading
              color: Theme.of(context).colorScheme.primary, // colored heading
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

// ---------------- INFO ROW ----------------
// Stateless: icon and text come from the constructor, so it just draws what it is given.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 6), // small gap
        Expanded(
          child: Text(text, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

// ---------------- STUDENT CARD ----------------
// Stateless: it shows one Student object passed in; if data changes, the parent rebuilds it.
class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // CUSTOMIZATION 3: rounded Card corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colors.primary, // CUSTOMIZATION 4: avatar color
              foregroundColor: colors.onPrimary,
              child: Text(
                student.name[0], // first letter of the name
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // CUSTOMIZATION 5: name TextStyle
                    ),
                  ),
                  Text(student.course),
                  const SizedBox(height: 8),
                  InfoRow(icon: Icons.school, text: 'Year ${student.yearLevel}'),
                  const SizedBox(height: 4),
                  InfoRow(icon: Icons.email, text: student.email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}