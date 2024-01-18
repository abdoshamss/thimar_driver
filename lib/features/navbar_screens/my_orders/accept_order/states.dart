part of 'bloc.dart';

class AcceptOrderStates {}

class AcceptOrderLoadingState extends AcceptOrderStates {}

class AcceptOrderSuccessState extends AcceptOrderStates {
  final String message;
  final BuildContext context;

  AcceptOrderSuccessState({required this.message, required this.context}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(38.r), topRight: Radius.circular(38.r))),
      builder: (context) => Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.images.confirmation.path),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  message,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp),
                ),
              ),
              Text("يمكنك متابعة الطلب لتسليم المنتجات وإنهائه",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.sp)),
              SizedBox(
                height: 16.h,
              ),
              AppButton(
                text: "متابعة الطلب",
                onPressed: () {
                  push(HomeNavBarScreen(currentPage: 1), );
                },
              )
            ],
          ),
        ),
      ),
    ).then((value) => Navigator.pop(context),);
  }
}

class AcceptOrderErrorState extends AcceptOrderStates {
  final String message;
  final int statusCode;

  AcceptOrderErrorState({required this.message, required this.statusCode});
}
