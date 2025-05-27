import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/employee_model.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  var allEmployees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;
  var selectedExpertise = ''.obs;
  var selectedEmployee = Rx<Employee?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  void fetchEmployees() {
    allEmployees.assignAll([
      Employee(
        name: 'Theresa Webb',
        expertise: 'Dakspecialist',
        imageUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      Employee(
        name: 'James Parker',
        expertise: 'Schimmelverwijderingsspecialist',
        imageUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      Employee(
        name: 'Linda Brown',
        expertise: 'Elektricien',
        imageUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      Employee(
        name: 'Robert Smith',
        expertise: 'Loodgieter',
        imageUrl: 'https://i.pravatar.cc/150?img=4',
      ),
      Employee(
        name: 'Jessica Green',
        expertise: 'Timmerman',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
      ),
      Employee(
        name: 'Michael Johnson',
        expertise: 'Algemene aannemer',
        imageUrl: 'https://i.pravatar.cc/150?img=6',
      ),
      Employee(
        name: 'Emily Davis',
        expertise: 'Interieurontwerper',
        imageUrl: 'https://i.pravatar.cc/150?img=7',
      ),
    ]);

    filteredEmployees.assignAll(allEmployees);
  }

  void filterByExpertise(String keyword) {
    selectedExpertise.value = keyword;
    filteredEmployees.value =
        allEmployees.where((e) => e.expertise == keyword).toList();
  }

  void searchEmployee(String query) {
    final lower = query.toLowerCase();
    filteredEmployees.value =
        allEmployees
            .where((e) => e.name.toLowerCase().contains(lower))
            .toList();
  }

  void selectEmployee(Employee employee) {
    selectedEmployee.value = employee;
  }
}
