import 'package:get/get.dart';

import '../modules/addCluster/bindings/add_cluster_binding.dart';
import '../modules/addCluster/views/add_cluster_view.dart';
import '../modules/addInterval/bindings/add_interval_binding.dart';
import '../modules/addInterval/views/add_interval_view.dart';
import '../modules/addLocation/bindings/add_location_binding.dart';
import '../modules/addLocation/views/add_location_view.dart';
import '../modules/addPanchayat/bindings/add_panchayat_binding.dart';
import '../modules/addPanchayat/views/add_panchayat_view.dart';
import '../modules/addVillage/bindings/add_village_binding.dart';
import '../modules/addVillage/views/add_village_view.dart';
import '../modules/amountUtilized/bindings/amount_utilized_binding.dart';
import '../modules/amountUtilized/views/amount_utilized_view.dart';
import '../modules/chooseRole/bindings/choose_role_binding.dart';
import '../modules/chooseRole/views/choose_role_view.dart';
import '../modules/expectedActual/bindings/expected_actual_binding.dart';
import '../modules/expectedActual/views/expected_actual_view.dart';
import '../modules/feedback/bindings/feedback_binding.dart';
import '../modules/feedback/views/feedback_view.dart';
import '../modules/generalInfo/bindings/general_info_binding.dart';
import '../modules/generalInfo/views/general_info_view.dart';
import '../modules/leverWise/bindings/lever_wise_binding.dart';
import '../modules/leverWise/views/lever_wise_view.dart';
import '../modules/locationWise/bindings/location_wise_binding.dart';
import '../modules/locationWise/views/location_wise_view.dart';
import '../modules/monitorProgress/bindings/monitor_progress_binding.dart';
import '../modules/monitorProgress/views/monitor_progress_view.dart';
import '../modules/overviewPan/bindings/overview_pan_binding.dart';
import '../modules/overviewPan/views/overview_pan_view.dart';
import '../modules/performanceVdf/bindings/performance_vdf_binding.dart';
import '../modules/performanceVdf/views/performance_vdf_view.dart';
import '../modules/replaceVdf/bindings/replace_vdf_binding.dart';
import '../modules/replaceVdf/views/replace_vdf_view.dart';
import '../modules/reports/bindings/reports_binding.dart';
import '../modules/reports/views/reports_view.dart';
import '../modules/sourceFunds/bindings/source_funds_binding.dart';
import '../modules/sourceFunds/views/source_funds_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.REPORTS,
      page: () => const ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: _Paths.GENERAL_INFO,
      page: () => const GeneralInfoView(),
      binding: GeneralInfoBinding(),
    ),
    GetPage(
      name: _Paths.MONITOR_PROGRESS,
      page: () => const MonitorProgressView(),
      binding: MonitorProgressBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INTERVAL,
      page: () => const AddIntervalView(),
      binding: AddIntervalBinding(),
    ),
    GetPage(
      name: _Paths.ADD_LOCATION,
      page: () => AddLocationView(),
      binding: AddLocationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PANCHAYAT,
      page: () => AddPanchayatView(),
      binding: AddPanchayatBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VILLAGE,
      page: () => const AddVillageView(),
      binding: AddVillageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CLUSTER,
      page: () => AddClusterView(),
      binding: AddClusterBinding(),
    ),
    GetPage(
      name: _Paths.REPLACE_VDF,
      page: () => ReplaceVdfView(),
      binding: ReplaceVdfBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => const FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: _Paths.OVERVIEW_PAN,
      page: () => const OverviewPanView(),
      binding: OverviewPanBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_WISE,
      page: () => const LocationWiseView(),
      binding: LocationWiseBinding(),
    ),
    GetPage(
      name: _Paths.LEVER_WISE,
      page: () => const LeverWiseView(),
      binding: LeverWiseBinding(),
    ),
    GetPage(
      name: _Paths.AMOUNT_UTILIZED,
      page: () => const AmountUtilizedView(),
      binding: AmountUtilizedBinding(),
    ),
    GetPage(
      name: _Paths.SOURCE_FUNDS,
      page: () => const SourceFundsView(),
      binding: SourceFundsBinding(),
    ),
    GetPage(
      name: _Paths.EXPECTED_ACTUAL,
      page: () => const ExpectedActualView(),
      binding: ExpectedActualBinding(),
    ),
    GetPage(
      name: _Paths.PERFORMANCE_VDF,
      page: () => const PerformanceVdfView(),
      binding: PerformanceVdfBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_ROLE,
      page: () => const ChooseRoleView(),
      binding: ChooseRoleBinding(),
    ),
  ];
}
