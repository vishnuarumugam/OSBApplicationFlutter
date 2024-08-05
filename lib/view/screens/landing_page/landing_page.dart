import '../../../app/app.dart';

class LandingPage extends StatefulWidget {
  final bool isDarkMode = false;
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    context.read<LandingPageViewModel>().setBottomNavBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<LandingPageViewModel>(
          builder: (context, landingPageViewModel, child) {
        return Scaffold(
          bottomNavigationBar: AppBottomNavBarWidget(
            backgroundColor: Color(0xFFF9EDDE),
            selectedIndex: landingPageViewModel.selectedIndex,
            height: 50,
            destinations: landingPageViewModel.navBarDestinations,
            mode: widget.isDarkMode ? Mode.darkMode : Mode.lightMode,
            onDestinationSelected: (index) {
              landingPageViewModel.selectedIndex = index;
              setState(() {});
            },
          ),
          body: RefreshIndicator(
              key: refreshKey,
              onRefresh: () async {},
              child: landingPageViewModel
                  .widgetOptions[landingPageViewModel.selectedIndex]),
        );
      }),
    );
  }
}
