// import 'package:baby_receptionist/business_logic/blocs/NewInvoiceBloc.dart';
// import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
// import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
// import 'package:baby_receptionist/data/models/Arguments/InvoiceArguments.dart';
// import 'package:baby_receptionist/data/models/Sample/DoctorSample.dart';
// import 'package:baby_receptionist/data/models/Sample/ProcedureSample.dart';
// import 'package:baby_receptionist/presentation/constants/QColor.dart';
// import 'package:baby_receptionist/presentation/constants/QPadding.dart';
// import 'package:baby_receptionist/presentation/constants/QString.dart';
// import 'package:baby_receptionist/presentation/widgets/QErrorWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
//
// class NewInvoice extends StatefulWidget {
//   final InvoiceArguments arguments;
//
//   const NewInvoice({@required this.arguments});
//
//   @override
//   _NewInvoiceState createState() => _NewInvoiceState();
// }
//
// class _NewInvoiceState extends State<NewInvoice> {
//   final bloc = NewInvoiceBloc();
//   bool hasChangeDependencies = false;
//   final tecConsultationFee = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     bloc.changeDoctorTypeText(QString.txtDoctorType);
//     bloc.changeInvoiceType('Consultation');
//     bloc.changeProcedureType('room');
//   }
//
//   @override
//   Future<void> didChangeDependencies() async {
//     if (!hasChangeDependencies) {
//       if (await bloc.checkTokenValidity(
//           context: context,
//           hasProgressBar: false,
//           dialogType: QString.dialogSubmitting)) {
//         bloc.getDoctorsAndLinkToForm(
//             token: context.read<TokenProvider>().tokenSample.jwtToken);
//       }
//       hasChangeDependencies = true;
//     }
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     tecConsultationFee.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: QColor.globalBackgroundColor,
//       appBar: AppBar(
//         title: Text(QString.titleAddInvoice),
//         centerTitle: false,
//         backgroundColor: QColor.globalAppBarColor,
//         elevation: 0.0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               widgetProcedureType(),
//               widgetProcedureTypeWalkin(),
//               Row(
//                 children: [
//                   Expanded(child: widgetPreviousDate()),
//                   Expanded(child: widgetCurrentDate()),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(child: widgetChildName()),
//                   Expanded(child: widgetFatherName()),
//                   Expanded(child: widgetBirthDate()),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(child: widgetEmail()),
//                   Expanded(child: widgetContactNumber()),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(child: widgetDoctorName()),
//                   Expanded(child: widgetDoctorType()),
//                 ],
//               ),
//               widgetProcedureInventoryList(),
//               widgetPaymentType(),
//               widgetTotal(),
//               widgetDiscount(),
//               widgetNetTotal(),
//               widgetDisposable(),
//               widgetGrossTotal(),
//               widgetSubmit(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget widgetSelectNote(text) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(15, 15, 10, 5),
//       child: Text(
//         text,
//         style: TextStyle(fontWeight: FontWeight.w600),
//       ),
//     );
//   }
//
//   Widget widgetProcedureInventoryList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         StreamBuilder<List<ProcedureSample>>(
//           stream: bloc.procedureList,
//           builder: (context, snapshot) {
//             return snapshot.hasData
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       widgetSelectNote('Select Procedures:'),
//                       ListView.builder(
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (context, i) {
//                           return Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 1,
//                                         child: Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               5, 0, 5, 0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                   color: QColor
//                                                       .globalNormalInputBorder,
//                                                   style: BorderStyle.solid),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       0, 8, 0, 8),
//                                               child: Row(
//                                                 children: [
//                                                   Checkbox(
//                                                       value: snapshot.data[i]
//                                                           .procedureChecked,
//                                                       onChanged: (bool value) {
//                                                         if (value) {
//                                                           snapshot.data[i]
//                                                                   .procedureChecked =
//                                                               value;
//                                                           bloc.changeProcedureList(
//                                                               snapshot.data);
//                                                         } else {
//                                                           snapshot.data[i]
//                                                                   .procedureChecked =
//                                                               value;
//                                                           snapshot
//                                                               .data[i]
//                                                               .tecCount
//                                                               .text = '';
//                                                           snapshot
//                                                               .data[i]
//                                                               .tecTotal
//                                                               .text = '0';
//                                                           bloc.changeProcedureList(
//                                                               snapshot.data);
//                                                         }
//                                                       }),
//                                                   Expanded(
//                                                     child: Text(
//                                                         snapshot.data[i].name),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       snapshot.data[i].procedureChecked
//                                           ? Expanded(
//                                               flex: 1,
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller: snapshot
//                                                           .data[i].tecCount,
//                                                       onChanged: (String text) {
//                                                         snapshot
//                                                             .data[i]
//                                                             .tecTotal
//                                                             .text = (text
//                                                                     .isEmpty
//                                                                 ? 0
//                                                                 : int.parse(snapshot
//                                                                         .data[i]
//                                                                         .tecCount
//                                                                         .text) *
//                                                                     snapshot
//                                                                         .data[i]
//                                                                         .charges)
//                                                             .toString();
//                                                         bloc.changeProcedureList(
//                                                             snapshot.data);
//                                                       },
//                                                       decoration:
//                                                           InputDecoration(
//                                                         labelText: 'Count',
//                                                         border:
//                                                             OutlineInputBorder(),
//                                                       ),
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       inputFormatters: <
//                                                           TextInputFormatter>[
//                                                         FilteringTextInputFormatter
//                                                             .digitsOnly
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 5),
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       readOnly: true,
//                                                       initialValue: snapshot
//                                                           .data[i].charges
//                                                           .toString(),
//                                                       decoration:
//                                                           InputDecoration(
//                                                         labelText:
//                                                             'Single Cost',
//                                                         border:
//                                                             OutlineInputBorder(),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 5),
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller: snapshot
//                                                           .data[i].tecTotal,
//                                                       readOnly: true,
//                                                       decoration:
//                                                           InputDecoration(
//                                                         labelText: 'Total',
//                                                         border:
//                                                             OutlineInputBorder(),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
//                                           : Expanded(flex: 1, child: Text(''))
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   )
//                 : StreamBuilder<bool>(
//                     stream: bloc.loadingProcedure,
//                     builder: (context, snapshot) {
//                       return snapshot.hasData
//                           ? Center(child: CircularProgressIndicator())
//                           : widgetConsultationFee();
//                     },
//                   );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget widgetGrossTotal() {
//     return StreamBuilder<String>(
//         stream: bloc.grossTotal,
//         builder: (context, snapshot) {
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: TextFormField(
//                   autofocus: false,
//                   onChanged: bloc.changeGrossTotal,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.monetization_on),
//                       errorText: snapshot.error,
//                       border: OutlineInputBorder(),
//                       labelText: 'GrossTotal (rupees)'),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   Widget widgetDisposable() {
//     return StreamBuilder<String>(
//         stream: bloc.disposible,
//         builder: (context, snapshot) {
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: TextFormField(
//                   autofocus: false,
//                   onChanged: bloc.changeDisposible,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.monetization_on),
//                       errorText: snapshot.error,
//                       border: OutlineInputBorder(),
//                       labelText: 'Disposable (rupees)'),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   Widget widgetNetTotal() {
//     return StreamBuilder<Object>(
//         stream: bloc.netTotal,
//         builder: (context, snapshot) {
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: TextFormField(
//                   autofocus: false,
//                   onChanged: bloc.changeNetTotal,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.monetization_on),
//                       border: OutlineInputBorder(),
//                       errorText: snapshot.error,
//                       labelText: 'Net Total (rupees)'),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   Widget widgetDiscount() {
//     return StreamBuilder<String>(
//         stream: bloc.discount,
//         builder: (context, snapshot) {
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: TextFormField(
//                   autofocus: false,
//                   onChanged: bloc.changeDiscount,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.monetization_on),
//                       errorText: snapshot.error,
//                       border: OutlineInputBorder(),
//                       labelText: 'Discount (rupees)'),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   Widget widgetTotal() {
//     return StreamBuilder<String>(
//         stream: bloc.totalAmount,
//         builder: (context, snapshot) {
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: TextFormField(
//                   autofocus: false,
//                   onChanged: bloc.changeTotalAmount,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.monetization_on),
//                       border: OutlineInputBorder(),
//                       errorText: snapshot.error,
//                       labelText: 'Total (rupees)'),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   Widget widgetProcedureType() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(color: Colors.grey)),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//           child: StreamBuilder<String>(
//               stream: bloc.ddbInvoiceType,
//               builder: (context, snapshot) {
//                 return !snapshot.hasData
//                     ? CircularProgressIndicator()
//                     : DropdownButton<String>(
//                         isExpanded: true,
//                         value: snapshot.data,
//                         elevation: 16,
//                         underline: Container(
//                           height: 0,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (value) async {
//                           bloc.changeInvoiceType(value);
//                           if (value == 'Procedure') {
//                             bloc.changeLoadingProcedure(true);
//                             if (await bloc.checkTokenValidity(
//                                 context: context,
//                                 hasProgressBar: false,
//                                 dialogType: QString.dialogSubmitting)) {
//                               bloc.getProceduresAndLinkToForm(
//                                   token: context
//                                       .read<TokenProvider>()
//                                       .tokenSample
//                                       .jwtToken);
//                             }
//                           } else {
//                             bloc.changeProcedureList(null);
//                             bloc.changeLoadingProcedure(null);
//                           }
//                         },
//                         items: <String>['Consultation', 'Procedure']
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       );
//               }),
//         ),
//       ),
//     );
//   }
//
//   Widget widgetPaymentType() {
//     return StreamBuilder<String>(
//       stream: bloc.paymentType,
//       builder: (context, snapshot) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                       color: !snapshot.hasError
//                           ? QColor.globalNormalInputBorder
//                           : QColor.globalErrorInputBorder,
//                       style: BorderStyle.solid),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 15.5, 10, 15.5),
//                   child: DropdownButtonFormField<String>(
//                     isExpanded: true,
//                     value: snapshot.data,
//                     hint: Text(QString.dbffSelectPaymentType),
//                     elevation: 16,
//                     decoration: InputDecoration.collapsed(
//                       hintText: '',
//                     ),
//                     onChanged: bloc.changePaymentType,
//                     items: <String>[
//                       QString.dbffSelectPaymentType,
//                       'Cash',
//                       'Credit Card',
//                       'Easypaisa'
//                     ].map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//               if (snapshot.hasError) QErrorWidget(error: snapshot.error),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget widgetConsultationFee() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: StreamBuilder<String>(
//               stream: bloc.txtConsultationFee,
//               builder: (context, snapshot) {
//                 return TextFormField(
//                   readOnly: true,
//                   controller: tecConsultationFee,
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.monetization_on),
//                       errorText: snapshot.error,
//                       border: OutlineInputBorder(),
//                       labelText: 'Consultation Fee'),
//                 );
//               }),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetDoctorName() {
//     return StreamBuilder<List<DoctorSample>>(
//         stream: bloc.doctorList,
//         builder: (context, snapshot) {
//           return !snapshot.hasData
//               ? Center(child: CircularProgressIndicator())
//               : Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(color: Colors.grey)),
//                     child: Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         child: StreamBuilder<DoctorSample>(
//                             stream: bloc.ddbDoctor,
//                             builder: (context, snapshotDropDown) {
//                               return !snapshotDropDown.hasData
//                                   ? CircularProgressIndicator()
//                                   : DropdownButton<DoctorSample>(
//                                       isExpanded: true,
//                                       elevation: 16,
//                                       value: snapshotDropDown.data,
//                                       underline: Container(
//                                         height: 0,
//                                         color: Colors.deepPurpleAccent,
//                                       ),
//                                       onChanged: (DoctorSample value) {
//                                         bloc.changeDdbDoctor(value);
//                                         bloc.changeDoctorTypeText(
//                                             value.specialityType);
//                                         bloc.changeConsultationFee(
//                                             value.consultationFee.toString());
//                                         tecConsultationFee.text =
//                                             value.consultationFee.toString();
//                                       },
//                                       items: snapshot.data
//                                           .map<DropdownMenuItem<DoctorSample>>(
//                                               (DoctorSample doctorSample) {
//                                         return DropdownMenuItem<DoctorSample>(
//                                           value: doctorSample,
//                                           child:
//                                               Text(doctorSample.user.firstName),
//                                         );
//                                       }).toList(),
//                                     );
//                             })),
//                   ),
//                 );
//         });
//   }
//
//   Widget widgetDoctorType() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(color: Colors.grey)),
//         child: Padding(
//             padding: const EdgeInsets.fromLTRB(10, 15.5, 10, 15.5),
//             child: StreamBuilder<String>(
//                 stream: bloc.doctorType,
//                 builder: (context, snapshot) {
//                   return snapshot.hasData
//                       ? Text(snapshot.data)
//                       : CircularProgressIndicator();
//                 })),
//       ),
//     );
//   }
//
//   Widget widgetProcedureTypeWalkin() {
//     return StreamBuilder<String>(
//       stream: bloc.procedureType,
//       builder: (context, snapshot) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: !snapshot.hasError
//                         ? QColor.globalNormalInputBorder
//                         : QColor.globalErrorInputBorder,
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Expanded(
//                                 flex: 1,
//                                 child: Text(
//                                   'Place',
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: RadioListTile(
//                                   title: const Text('Room'),
//                                   value: "Room",
//                                   groupValue: snapshot.data,
//                                   onChanged: bloc.changeProcedureType,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: RadioListTile(
//                                   title: const Text('Emergency'),
//                                   value: "Emergency",
//                                   groupValue: snapshot.data,
//                                   onChanged: bloc.changeProcedureType,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (snapshot.hasError) QErrorWidget(error: snapshot.error),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget widgetContactNumber() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: TextFormField(
//             readOnly: true,
//             initialValue: widget.arguments.contactNumber,
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.phone),
//                 border: OutlineInputBorder(),
//                 labelText: 'Contact Number'),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetEmail() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: TextFormField(
//             readOnly: true,
//             initialValue: widget.arguments.email,
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.email),
//                 border: OutlineInputBorder(),
//                 labelText: 'Email'),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetChildName() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: TextFormField(
//             readOnly: true,
//             initialValue: widget.arguments.name,
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(),
//                 labelText: 'Name'),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetFatherName() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: TextFormField(
//             readOnly: true,
//             initialValue: widget.arguments.fatherName,
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(),
//                 labelText: 'Father Name'),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetPreviousDate() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: TextFormField(
//             readOnly: true,
//             initialValue: widget.arguments.previousDate.substring(0, 10),
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.date_range),
//               border: OutlineInputBorder(),
//               labelText: 'Previous Visit Date',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetCurrentDate() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: TextFormField(
//             readOnly: true,
//             initialValue: widget.arguments.consultationDate.substring(0, 10),
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.date_range),
//               border: OutlineInputBorder(),
//               labelText: 'Today Visit Date',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetBirthDate() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: TextFormField(
//             readOnly: true,
//             initialValue: widget.arguments.dateOfBirth.substring(0, 10),
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.date_range),
//               border: OutlineInputBorder(),
//               labelText: 'Date of Birth',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget widgetSubmit() {
//     return StreamBuilder<bool>(
//         stream: bloc.isFormValid,
//         builder: (context, snapshot) {
//           return Column(
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
//                   child: ElevatedButton(
//                     autofocus: false,
//                     style: ElevatedButton.styleFrom(
//                       primary: QColor.submitButtonColor,
//                       minimumSize: Size(double.infinity, 45),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     ),
//                     child: Text('Submit'),
//                     onPressed: () async {
//                       try {
//                         bloc.validateFields(context);
//                         if (snapshot.hasData) {
//                           if (await bloc.checkTokenValidity(
//                               context: context,
//                               dialogType: QString.dialogSubmitting,
//                               hasProgressBar: true)) {
//                             if (await bloc.onInsertInvoice(
//                                 context: context,
//                                 token: context
//                                     .read<TokenProvider>()
//                                     .tokenSample
//                                     .jwtToken,
//                                 invoiceArguments: widget.arguments)) {
//                               Navigator.pop(context);
//                             }
//                           }
//                         }
//                       } catch (exception) {
//                         GlobalSnackbar.showMessageUsingSnackBar(
//                             QColor.snackGlobalFailed,
//                             exception.toString(),
//                             context);
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
// }
