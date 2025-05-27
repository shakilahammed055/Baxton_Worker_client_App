// lib/pages/task_details_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_details_controller.dart'; // Ensure this path is correct
import 'widgets/image_picker_button.dart'; // Import the new widget

class TaskDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taakdetails')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<TaskDetailsController>(
          init: TaskDetailsController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jouw voortgang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: controller.progress.value / 100,
                      color: Colors.blue,
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${controller.progress.value}% Voltooid',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),

                // Task Checklist
                SizedBox(height: 20),
                Text(
                  'Taakchecklist',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    ImagePickerButton(controller: controller, index: 0),
                    ImagePickerButton(controller: controller, index: 1),
                  ],
                ),
                SizedBox(height: 16),
                // Client Signature Request
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: controller.takeClientSignature,
                      child: Text('Vraag om de handtekening van de klant'),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Note
                TextField(
                  onChanged: controller.updateNoteText,
                  decoration: InputDecoration(
                    labelText: 'Note',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),

                // Task Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: controller.pauseTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: Text('Taak Pauzeren'),
                    ),
                    ElevatedButton(
                      onPressed: controller.completeTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Taak voltooien'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
