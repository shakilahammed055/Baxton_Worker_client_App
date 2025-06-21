// lib/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart
import 'package:baxton/features/Admin_flow/betalingsbeheer/model/task_status_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/model/invoice_model.dart';

class BetalingsbeheerController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  // Reactive variables for filters
  final Rx<String?> selectedMonth = Rx<String?>(null);
  final Rx<String?> selectedTaaktype = Rx<String?>(null);
  final Rx<String?> selectedTaakStatus = Rx<String?>(null);
  final Rx<String?> selectedYear = Rx<String?>(null);

  var assignedTo = 'Theresa Webb'.obs;
  var expertise = 'Dak Specialist';
  var status = 'Betaling in afwachting'.obs;
  var amount = '\$5000'.obs;

  List<String> assignees = ['Theresa Webb', 'John Doe', 'Emma Brown'];
  List<String> statusOptions = [
    'Betaling in afwachting',
    'Bevestigd',
    'Voltooid',
  ];

  // Invoices list
  final RxList<Invoice> invoices =
      <Invoice>[
        Invoice(
          invoiceNumber: 'INV-2025-001',
          customerName: 'Bob Johnson',
          taskName: 'Schimmelinspectie',
          amount: '\$2000',
          date: '03/05/2025',
          status: PaymentStatus.pending,
        ),
        Invoice(
          invoiceNumber: 'INV-2025-002',
          customerName: 'Alice Smith',
          taskName: 'Asbest inspectie',
          amount: '\$2500',
          date: '04/05/2025',
          status: PaymentStatus.confirmed,
        ),
        Invoice(
          invoiceNumber: 'INV-2025-003',
          customerName: 'Charlie Brown',
          taskName: 'Bouw inspectie',
          amount: '\$1800',
          date: '05/05/2025',
          status: PaymentStatus.overdue,
        ),
        Invoice(
          invoiceNumber: 'INV-2025-001',
          customerName: 'Bob Johnson',
          taskName: 'Schimmelinspectie',
          amount: '\$2000',
          date: '03/05/2025',
          status: PaymentStatus.pending,
        ),
      ].obs;

  // Stats
  final dollar =
      TaskStatsModel(
        assigned: 12500,
        inProgress: 3200,
        completed: 1000,
        overdue: 8300,
        unassigned: 5,
      ).obs;

  // Setters
  void setSelectedMonth(String? month) => selectedMonth.value = month;
  void setSelectedTaakType(String? type) => selectedTaaktype.value = type;
  void setSelectedTaakStatus(String? status) =>
      selectedTaakStatus.value = status;
  void setSelectedYear(String? year) => selectedYear.value = year;

  // Clear all filters
  void clearAllFilters() {
    selectedMonth.value = null;
    selectedTaaktype.value = null;
    selectedTaakStatus.value = null;
    selectedYear.value = null;
  }

  // Check if all filters are selected
  bool get allFiltersSelected =>
      selectedMonth.value != null &&
      selectedYear.value != null &&
      selectedTaaktype.value != null &&
      selectedTaakStatus.value != null;

  final List<String> profiles = [
    'Theresa Webb',
    'John Doe',
    'Jane Smith',
    'Alex Johnson',
  ];

  // Selected value (initially set to the first profile)
  String selectedProfile = 'Theresa Webb';

  // Method to update the selected profile
  void updateSelectedProfile(String? newValue) {
    if (newValue != null) {
      selectedProfile = newValue;
    }
  }
}
