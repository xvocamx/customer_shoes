import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade800,
                Colors.blue.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            )
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                         Text("Sign Up",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 22.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                        SizedBox(height: 10,),
                        Text("Create an account, it's free",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18.0,
                             fontWeight: FontWeight.w300,
                           ),
                         )
                      ],
                    ),
                  )

              ),
              Expanded(flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFe7edeb),
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email,color: Colors.grey.shade600,),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFe7edeb),
                              hintText: "Name",
                              prefixIcon: Icon(Icons.person,color: Colors.grey.shade600,),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFe7edeb),
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock,color: Colors.grey.shade600,),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFe7edeb),
                              hintText: "Comfirm Password",
                              prefixIcon: Icon(Icons.lock,color: Colors.grey.shade600,),

                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 17),),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)
                                  )
                                ),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              const Text("Already have an account?"),
                              TextButton(
                                child: const Text("Sign In", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,),
                                ),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Image extends StatelessWidget {
  const Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height/2,
        )
      ],
    );
  }
}

