import '../../../app/app.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 10, backgroundColor: AppColors.colorDark),
        backgroundColor: AppColors.colorDark,
        body: design(context));
  }

  Container design(BuildContext pageContext) {
    return Container(
      height: MediaQuery.sizeOf(pageContext).height,
      width: MediaQuery.sizeOf(pageContext).width,
      decoration: const BoxDecoration(color: AppColors.colorLight),
      child: ListView(
        children: [topDesign(), bottomDesign(pageContext)],
      ),
    );
  }

  Stack bottomDesign(BuildContext pageContext) {
    return Stack(children: [
      Container(
        height: 50,
        decoration: const BoxDecoration(
          color: AppColors.colorDark,
        ),
      ),
      Container(
          height: 50,
          decoration: const BoxDecoration(
              color: AppColors.colorLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ))),
      bottomDesignContent(pageContext)
    ]);
  }

  Padding bottomDesignContent(BuildContext pageContext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 60),
        const Text(AppStringConstants.welcomeBack,
            style: AppStyles.headingBlack16),
        const SizedBox(height: 30),
        const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 5),
            child: Text(AppStringConstants.emailAddress,
                style: AppStyles.inputHeaderBlack12)),
        const SizedBox(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppStringConstants.enterEmailAddress,
              hintStyle: AppStyles.inputHintTvStyle,
              fillColor: AppColors.colorWhite,
              filled: true,
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 5),
            child: Text(AppStringConstants.password,
                style: AppStyles.inputHeaderBlack12)),
        const SizedBox(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppStringConstants.enterPassword,
              hintStyle: AppStyles.inputHintTvStyle,
              fillColor: AppColors.colorWhite,
              filled: true,
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        GestureDetector(
            onTap: () {
              pushToScreen(pageContext, const DashboardPage());
            },
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 45),
                decoration: const BoxDecoration(
                    color: AppColors.colorBlack,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Text(
                  AppStringConstants.login,
                  style: AppStyles.buttonTvStyle,
                ))),
        const SizedBox(height: 25),
      ]),
    );
  }

  Container topDesign() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.colorDark),
      child: Column(
        children: [
          const SizedBox(height: 85),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(right: 25, top: 10),
                child: Text(AppStringConstants.om,
                    style: AppStyles.headingSacWhite36),
              ),
              SvgPicture.asset(AppImageConstants.leafIcon,
                  height: 50, width: 50)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(AppStringConstants.saravanaBhavan.toUpperCase(),
                  style: AppStyles.headingWhite24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
                alignment: Alignment.topLeft,
                child: const Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Divider(
                        color: AppColors.colorHighlighter,
                        height: 20,
                        thickness: 2.5,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(AppStringConstants.pureVegeterian,
                              style: AppStyles.subheadingHighlight14),
                        )),
                    // Expanded(
                    //   flex: 1,
                    //   child: Divider(
                    //     color: AppColors.colorHighlighter,
                    //     height: 20,
                    //     thickness: 2.5,
                    //   ),
                    // ),
                  ],
                )),
          ),
          const SizedBox(height: 85),
        ],
      ),
    );
  }
}
