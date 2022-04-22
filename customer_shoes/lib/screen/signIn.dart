import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                Colors.orangeAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Login",style: TextStyle(color: Colors.white,fontSize: 46),),
                        SizedBox(height: 10.0,),
                        Text("Chào mừng đến với shop shoes",style: TextStyle(color: Colors.white,fontSize: 20),),
                      ],
                    ),
                  )
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0)
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
                              prefixIcon: Icon(Icons.email, color: Colors.grey.shade600),
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
                              prefixIcon: Icon(Icons.lock, color: Colors.grey.shade600),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: (){},
                                child: const Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 17),),
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
                            children: [
                              const Text("Don't have account ?"),
                              TextButton(
                                child: const Text("Sign Up", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,),
                                ),
                                onPressed: () => Navigator.pushNamed(context, '/signUp'),
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
