import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ's",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FAQItem(
              question: 'How can I add expenses?',
              answer:
              'To add expenses, go to the Home Page, and tap on the "+" button and click Add Expenses. Fill in the details and save.',
            ),
            FAQItem(
              question: 'Can I track my incomes?',
              answer:
              'Yes, you can. Navigate to the Home Page and tap the View Incomes and it will navigate you to view your incomes based on monthly basis, and also you can view it from the Expenses Page, a Income named button will be displayed at the top of the page, click and view it',
            ),
            FAQItem(
              question: 'How do I manage leaves?',
              answer:
              'In the Personal Page, there is new Feature of Leave Tracker, tap on it and you can add, view, update, or delete your leave information as needed.',
            ),
            FAQItem(
              question: 'Where can I update personal information?',
              answer:
              'Update your personal information in the "Settings" Page, User Profile Section of the app.',
            ),
            FAQItem(
              question: 'Is there a health tracking feature?',
              answer:
              'Yes, you can track health-related information in the "Health" section of the app, which is available inside the Top Navigation bar',
            ),
            FAQItem(
              question: 'How can I view and analyze my expenses?',
              answer:
              'Use the "Analytics" page to view and analyze your expenses with charts and graphs, where the analytics will be divided and displayed for both expenses and incomes and also for your Leave Days',
            ),
            FAQItem(
              question: 'Can I calculate mileage?',
              answer:
              'Yes, the mileage calculator is available in the "Mileage Calculator" section, which will be displayed inside the Top Navigation Bar',
            ),
            FAQItem(
                question: 'What is Top-Nav Bar, and where it is Located',
                answer: 'The Top Nav Bar which i have mentioned in the above answers are found at the top of the Page near the App Title, click on that menu-icon and view the added new features in it.'
            ),
            FAQItem(
                question: 'Could I able to view my Yearly Expenses and Incomes',
                answer: 'Yes you can, you can able to view your yearly expenses and incomes total in the Analytics Section of Analytics Page, which will be downloadable within few days / added feature in the next update'
            ),
            FAQItem(
                question: 'What are all the extra features in this App ?',
                answer: 'This App provides some extra features like Mileage Calculator, Health Tracker, Personal Diary, and Leave Tracker.'
            ),
            FAQItem(
                question: 'Is there a User Manual or Video to handle this App',
                answer: 'Sorry, as this is a Beta version, the user Manual Page is under deployment, soon the stable version will be released in which everything would be working fine.'
            ),
            FAQItem(
                question: 'Who Developed this App?',
                answer: 'This App was developed by a College Student named Sanjay Prasath Ganesh.'
            ),
            FAQItem(
                question: 'What was the Total Time Period for Deploying this App ? ',
                answer: 'This App took 1 month for Development and 7 days for Deployment'
            ),
            FAQItem(
                question: 'When this App was Released',
                answer: 'On December 09 2023'
            ),
            FAQItem(
                question: 'When will the stable version be Released?',
                answer: 'Expected to Release it in the next Year Start (2024)'
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          fontSize: 17.0,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer,style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            fontSize: 15.0,
          ),),
        ),
      ],
    );
  }
}
