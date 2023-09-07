import 'package:ln_employee/src/feature/employee/model/employee.dart';
import 'package:ln_employee/src/feature/employee/model/job_place.dart';
import 'package:ln_employee/src/feature/employee/model/salon.dart';
import 'package:ln_employee/src/feature/employee/model/user.dart';

final List<EmployeeModel> $staff = [
  EmployeeModel(
    id: 1,
    address: 'Воровского 186, кв 39',
    jobPlaceId: 1,
    salonId: 1,
    description: 'Лучший масте маникюра во всем Краснодаре',
    isDismiss: false,
    dateOfEmployment: DateTime.now(),
    contractNumber: '2938471294712384721',
    percentageOfSales: 8,
    stars: 4,
    salon: const SalonModel(
      id: 1,
      address: 'ул Степана Разина, д. 72',
      phone: '88005553535',
      email: 'okolashes@gmail.com',
      description: 'Лучший маникюрный салон в Краснодаре',
    ),
    user: UserDetailModel(
      id: 1,
      username: 'Zhorenty',
      password: 'blabla',
      email: 'zhorenty@gmail.com',
      firstName: 'Георгий',
      lastName: 'Волошин',
      phone: '89604875329',
      birthDate: DateTime.now().add(const Duration(days: 30)),
      isSuperuser: false,
      isActive: true,
    ),

    /// Должен быть лист
    jobPlace: const JobPlaceModel(
      id: 1,
      name: 'Мастер маникюра',
      oklad: 2000,
    ),
  )
];
