import 'package:baby_receptionist/business_logic/blocs/AddPatientBloc.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QEnum.dart';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/widgets/QErrorWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final formKey = GlobalKey<FormState>();

  final tecReferredDate = TextEditingController();
  final tecDateOfBirth = TextEditingController();
  final tecJoiningDate = TextEditingController();

  final bloc = AddPatientBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    tecDateOfBirth.dispose();
    tecReferredDate.dispose();
    tecJoiningDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QColor.globalBackgroundColor,
      appBar: AppBar(
        title: Text(QString.titleAddPatient),
        centerTitle: false,
        backgroundColor: QColor.globalAppBarColor,
        elevation: 0.0,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.minHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      QPadding.globalPaddingLeft,
                      QPadding.globalPaddingTop,
                      QPadding.globalPaddingRight,
                      QPadding.globalPaddingBottom),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widgetCategory(),
                        widgetFirstName(),
                        widgetLastName(),
                        widgetFatherHusbandName(),
                        widgetGender(),
                        widgetCnic(),
                        widgetContactNumber(),
                        widgetEmergencyContactNumber(),
                        widgetEmail(),
                        widgetAddress(),
                        widgetJoiningDate(),
                        widgetDateOfBirth(),
                        widgetFloorNo(),
                        widgetExperience(),
                        widgetPatientType(),
                        widgetStatus(),
                        widgetReligion(),
                        widgetPatientExternalID(),
                        widgetBloodGroup(),
                        widgetClinicSite(),
                        widgetReferredBy(),
                        widgetReferredDate(),
                        widgetParentGuardian(),
                        widgetPaymentProfile(),
                        widgetDescription(),
                        widgetSubmit(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> pickDate(initialDate, firstDate, lastDate, dateType) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (date != null) {
      if (dateType == DateType.birthDate) {
        tecDateOfBirth.text = date.toString().substring(0, 10);
        bloc.changeDateOfBirth(tecDateOfBirth.text);
      } else if (dateType == DateType.joining) {
        tecJoiningDate.text = date.toString().substring(0, 10);
        bloc.changeJoiningDate(tecJoiningDate.text);
      } else if (dateType == DateType.referred) {
        tecReferredDate.text = date.toString().substring(0, 10);
        bloc.changeReferredDate(tecReferredDate.text);
      }
    }
  }

  Widget widgetFirstName() {
    return StreamBuilder<String>(
        stream: bloc.firstName,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeFirstName,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'First Name'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetLastName() {
    return StreamBuilder<String>(
        stream: bloc.lastName,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeLastName,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Last Name'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetFatherHusbandName() {
    return StreamBuilder<String>(
        stream: bloc.fatherHusbandName,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeFatherHusbandName,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Father/Husband Name'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetGender() {
    return StreamBuilder<String>(
      stream: bloc.gender,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              QPadding.globalDropDownFieldLeft,
              QPadding.globalDropDownFieldTop,
              QPadding.globalDropDownFieldRight,
              QPadding.globalDropDownFieldBottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: !snapshot.hasError
                          ? QColor.globalNormalInputBorder
                          : QColor.globalErrorInputBorder,
                      style: BorderStyle.solid),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      QPadding.globalDbffLeft,
                      QPadding.globalDbffTop,
                      QPadding.globalDbffRight,
                      QPadding.globalDbffBottom),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: 'Choose Gender',
                    elevation: 16,
                    decoration: InputDecoration.collapsed(
                      hintText: '',
                    ),
                    onChanged: bloc.changeGender,
                    items: <String>[
                      'Choose Gender',
                      'Male',
                      'Female',
                      'Other',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (snapshot.hasError) QErrorWidget(error: snapshot.error),
            ],
          ),
        );
      },
    );
  }

  Widget widgetCnic() {
    return StreamBuilder<String>(
        stream: bloc.identityCard,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeIdentityCard,
                  maxLength: 13,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.credit_card),
                      errorText: snapshot.error,
                      counterText: QString.emptyString,
                      border: OutlineInputBorder(),
                      labelText: 'CNIC Number'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetContactNumber() {
    return StreamBuilder<String>(
        stream: bloc.contactNumber,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeContactNumber,
                  maxLength: 11,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      errorText: snapshot.error,
                      counterText: QString.emptyString,
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetFloorNo() {
    return StreamBuilder<String>(
        stream: bloc.floorNo,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeFloorNo,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Floor Number'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetExperience() {
    return StreamBuilder<String>(
        stream: bloc.experience,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeExperience,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Experience'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetEmergencyContactNumber() {
    return StreamBuilder<String>(
        stream: bloc.emergencyContactNumber,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeEmergencyContactNumber,
                  maxLength: 11,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      counterText: QString.emptyString,
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Emergency Contact Number'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetEmail() {
    return StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeEmail,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Email'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetAddress() {
    return StreamBuilder<String>(
        stream: bloc.address,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Address'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetJoiningDate() {
    return StreamBuilder<String>(
        stream: bloc.joiningDate,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  controller: tecJoiningDate,
                  onChanged: bloc.changeJoiningDate,
                  maxLength: 10,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    errorText: snapshot.error,
                    counterText: QString.emptyString,
                    border: OutlineInputBorder(),
                    labelText: 'Admitted Date',
                  ),
                  onTap: () => pickDate(
                      DateTime.now(),
                      DateTime(DateTime.now().year - 1),
                      DateTime(DateTime.now().year + 1),
                      DateType.joining),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetDateOfBirth() {
    return StreamBuilder<String>(
      stream: bloc.dateOfBirth,
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  QPadding.globalInputFieldLeft,
                  QPadding.globalInputFieldTop,
                  QPadding.globalInputFieldRight,
                  QPadding.globalInputFieldBottom),
              child: TextFormField(
                controller: tecDateOfBirth,
                onChanged: bloc.changeDateOfBirth,
                maxLength: 10,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.date_range),
                  errorText: snapshot.error,
                  counterText: QString.emptyString,
                  border: OutlineInputBorder(),
                  labelText: 'Date Of Birth',
                ),
                onTap: () => pickDate(DateTime.now(), DateTime(1900),
                    DateTime.now(), DateType.birthDate),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget widgetCategory() {
    return StreamBuilder<String>(
        stream: bloc.category,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
                QPadding.globalRadioButtonLeft,
                QPadding.globalRadioButtonTop,
                QPadding.globalRadioButtonRight,
                QPadding.globalRadioButtonBottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: !snapshot.hasError
                            ? QColor.globalNormalInputBorder
                            : QColor.globalErrorInputBorder,
                        style: BorderStyle.solid),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Patient Category',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Walk In'),
                                    value: "WalkIn",
                                    groupValue: snapshot.data,
                                    onChanged: bloc.changeCategory,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('On Call'),
                                    value: "OnCall",
                                    groupValue: snapshot.data,
                                    onChanged: bloc.changeCategory,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (snapshot.hasError) QErrorWidget(error: snapshot.error),
              ],
            ),
          );
        });
  }

  Widget widgetPatientType() {
    return StreamBuilder<String>(
        stream: bloc.patientType,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
                QPadding.globalRadioButtonLeft,
                QPadding.globalRadioButtonTop,
                QPadding.globalRadioButtonRight,
                QPadding.globalRadioButtonBottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: !snapshot.hasError
                            ? QColor.globalNormalInputBorder
                            : QColor.globalErrorInputBorder,
                        style: BorderStyle.solid),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Patient Type',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Panel'),
                                    value: "Panel",
                                    groupValue: snapshot.data,
                                    onChanged: bloc.changePatientType,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Non-Panel'),
                                    value: "Non-Panel",
                                    groupValue: snapshot.data,
                                    onChanged: bloc.changePatientType,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (snapshot.hasError) QErrorWidget(error: snapshot.error),
              ],
            ),
          );
        });
  }

  Widget widgetStatus() {
    return StreamBuilder<String>(
        stream: bloc.status,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeStatus,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Status (Optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetPatientExternalID() {
    return StreamBuilder<String>(
        stream: bloc.patientExternalId,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changePatientExternalId,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Patient External ID (optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetBloodGroup() {
    return StreamBuilder<String>(
        stream: bloc.bloodGroup,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeBloodGroup,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Blood Group (optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetClinicSite() {
    return StreamBuilder<String>(
        stream: bloc.clinicSite,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeClinicSite,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_hospital),
                      border: OutlineInputBorder(),
                      labelText: 'Clinic Site (optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetReferredBy() {
    return StreamBuilder<String>(
        stream: bloc.referredBy,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeReferredBy,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Referred By (optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetReferredDate() {
    return StreamBuilder<String>(
        stream: bloc.referredDate,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  controller: tecReferredDate,
                  maxLength: 10,
                  onChanged: bloc.changeReferredDate,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    counterText: QString.emptyString,
                    errorText: snapshot.error,
                    border: OutlineInputBorder(),
                    labelText: 'Referred Date (Optional)',
                  ),
                  onTap: () => pickDate(
                      DateTime.now(),
                      DateTime(DateTime.now().year - 1),
                      DateTime(DateTime.now().year + 1),
                      DateType.referred),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetReligion() {
    return StreamBuilder<String>(
        stream: bloc.religon,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeReligon,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Religion (optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetParentGuardian() {
    return StreamBuilder<String>(
        stream: bloc.parentGuardian,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeParentGuardian,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Parent/Guardian(optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetPaymentProfile() {
    return StreamBuilder<String>(
        stream: bloc.paymentProfile,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changePaymentProfile,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.payments_outlined),
                      border: OutlineInputBorder(),
                      labelText: 'Payment Profile (optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetDescription() {
    return StreamBuilder<String>(
        stream: bloc.description,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeDescription,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.payments_outlined),
                      border: OutlineInputBorder(),
                      labelText: 'Description (optional)'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetSubmit() {
    return StreamBuilder<bool>(
        stream: bloc.isFormValid,
        builder: (context, snapshot) {
          return Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      QPadding.globalInputFieldLeft,
                      QPadding.globalInputFieldTop,
                      QPadding.globalInputFieldRight,
                      QPadding.globalInputFieldBottom),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: QColor.submitButtonColor,
                        minimumSize: Size(double.infinity, 45),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                      child: Text('Submit'),
                      onPressed: () async {
                        bloc.validateFields();
                        if (snapshot.hasData) {
                          if (await bloc.checkTokenValidity(context)) {
                            if (await bloc.onInsertPatient(
                                context,
                                context
                                    .read<TokenProvider>()
                                    .tokenSample
                                    .jwtToken)) {
                              formKey.currentState.reset();
                              bloc.changeCategory('');
                              bloc.changePatientType('');
                            }
                          }
                        } else {
                          GlobalSnackbar.showMessageUsingSnackBar(
                              QColor.snackGlobalFailed,
                              QError.emptyInputFields,
                              context);
                        }
                      }),
                ),
              ),
            ],
          );
        });
  }
}
