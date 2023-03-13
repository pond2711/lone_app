import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MotorPage extends StatefulWidget {
  const MotorPage({Key? key}) : super(key: key);
  @override
  State<MotorPage> createState() => _MotorPageState();
}

class _MotorPageState extends State<MotorPage> {
  final formKey = GlobalKey<FormState>();
  var objFormatDouble = NumberFormat('#,##0.00');
  var objFormatInt = NumberFormat('#,##0');
  String strUsername = "";
  String strDisplay = "";
  double douPrice = 0.00;
  double douDown = 0.00;
  double douPayment = 0.00;
  double douInterestrate = 0.00;
  double douPrincipal = 0.00;
  double douPay = 0.00;
  int intPeriod = 0;
  void FormSubmit() {
    if (formKey.currentState!.validate()) {
      //ตรวจว่าผ่านไหม
      formKey.currentState!.save(); //บันทึกค่า
    }
  }

  void FormReset() {
    formKey.currentState!.reset();
    setState(() {
      strDisplay = "";
    });
  }

  void SetDownPay(value) {
    setState(() {
      douDown = double.parse(value);
      SetDisplay();
    });
  }

  void SetPeriod(value) {
    setState(() {
      intPeriod = int.parse(value);
      SetDisplay();
    });
  }

  void setPrice(value) {
    setState(() {
      douPrice = double.parse(value);
      SetDisplay();
    });
  }

  void setInterestrate(value) {
    setState(() {
      douInterestrate = double.parse(value);
      SetDisplay();
    });
  }
  
  void calculator() {
    douPayment = douPrice * (douDown / 100);
    douPrincipal = ((douPrice-douPayment) * (douInterestrate / 100)) * intPeriod;
    douPay = (douPrincipal + (douPrice-douPayment)) / (intPeriod * 12);
  }

  void SetDisplay() {
    setState(() {
      calculator();
      strDisplay =
          'Down Payment is ${objFormatDouble.format(douPayment)} THB \nPrincipal is ${objFormatDouble.format(douPrice-douPayment)} THB \nInterest is ${objFormatDouble.format(douPrincipal)} THB\nYour Installment plan is ${objFormatDouble.format(douPay)} THB/month x ${intPeriod * 12} months';
    });
  }

  void calAge() {
    setState(() {
      formKey.currentState!.save();
      SetDisplay();
    });
  }

   void SetUsername(value) {
    setState(() {
      strUsername = value;
      SetDisplay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        //เก็บค่่า input
        key: formKey,
        child: Column(
          children: [                               //children use Alignment
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Motorcycle Installment",                
                style: TextStyle(fontSize: 30),
                ),
            ),
            SizedBox(height: 30.0,),
            PriceFormField(),
            DownFormField(),
            PeriodFormField(),
            InterestFormField(),
            
            SizedBox(height: 20.0),
            Text(
              '$strDisplay',
              style: TextStyle(fontSize: 20),  
            ),
            Align(alignment: Alignment.topLeft,),
            SizedBox(
              height: 40.0,
            ),
            Row(                                         //row use mainAxisAlignment
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                resetButton(),
                calculationButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget PriceFormField() {
    return TextFormField(
      //keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Price(10,000.00-1,000,000.00 THB) ",
        hintText: "Input Price",
        icon: Icon(Icons.motorcycle),
      ),
      validator: (value) {
        if (double.parse(value!) < 10000 || double.parse(value) > 1000000) {
          return "Price must between 10,000.00 - 1,000,000 ";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setPrice(value);
      },
    );
  }

  Widget DownFormField() {
    return TextFormField(
      //keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Down Payment (0.00-50.00 %)",
        hintText: "Input Down Payment",
        icon: Icon(Icons.payment),
      ),
      validator: (value) {
        if (double.parse(value!) < 1 || double.parse(value) > 50) {
          return "Down Payment must be between 0.00 - 50.00";
        } else {
          
          return null;
        }
      },
      onSaved: (value) {
        SetDownPay(value);
      },
    );
  }

  Widget PeriodFormField() {
    return TextFormField(
      obscureText: false, //เป็น......ใน pasword
      decoration: InputDecoration(
          labelText: "Period (1-5 yrs)",
          hintText: "Input Period",
          icon: Icon(Icons.calendar_month)),
      validator: (value) {
        if (int.parse(value!) < 1 || double.parse(value) > 5) {
          return "Period must be between 1-5";
        } else {
          
          return null;
        }
      },
      onSaved: (value) {
        SetPeriod(value);
      },
    );
  }

  Widget InterestFormField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Interest Rate (0.00-5.00 %/yr.)",
          hintText: "Input Interest Rate",
          icon: Icon(Icons.interests)),
      validator: (value) {
        if (double.parse(value!) < 1 || double.parse(value) > 5) {
          return "Interest Rate must be between 1-5";
        } else {
          
          return null;
        }
      },
      onSaved: (value) {
        setInterestrate(value);
      },
    );
  }

  Widget resetButton() {
    return ElevatedButton(
      //color: Colors.orangeAccent,
      onPressed: FormReset,
      child: Text("Reset"),
    );
  }

  Widget calculationButton() {
    return ElevatedButton(
      //color: Colors.orangeAccent,
      onPressed: FormSubmit,
      child: Text("Calculation"),
    );
  }
}
