import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:leavemanagementadmin/constant.dart';
import 'package:leavemanagementadmin/widget/filter.dart';

class AddBalPopUp extends StatefulWidget {
  const AddBalPopUp({super.key});

  @override
  State<AddBalPopUp> createState() => _AddBalPopUpState();
}

class _AddBalPopUpState extends State<AddBalPopUp> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 2,
      child: AlertDialog(
        elevation: 10,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OnHoverButton(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blueGrey),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                    onTap: () {},
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      elevation: 15,
                      child: const OnHoverButton(
                        child: CardWidget(
                            color: Colors.green,
                            width: 70,
                            height: 30,
                            borderRadius: 5,
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    )),
              )
            ],
          ),
        ],
        title: const Text(
          "Add Leave Balance",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: 200.0,
          width: 400.0,
          child: Form(
            child: SizedBox(
              width: 300,
              height: 725,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 237, 237),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color.fromARGB(255, 225, 222, 222))),
                    child: DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        searchFieldProps: const TextFieldProps(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                constraints: BoxConstraints(maxHeight: 40))),
                        constraints: BoxConstraints.tight(const Size(250, 250)),
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      // items:
                      // alldesignstate.alldesignationnamelist,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          labelText: "Employee Name :",
                          hintText: "Select Employee Name",
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          // dropdownvalue1 = newValue as String;
                        });

                        // dropdownvalue11 = alldesignstate.designidwithname.keys.firstWhere((k) => alldesignstate.designidwithname[k] == dropdownvalue1, orElse: () => null);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 237, 237),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color.fromARGB(255, 225, 222, 222))),
                    child: DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        searchFieldProps: const TextFieldProps(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                constraints: BoxConstraints(maxHeight: 40))),
                        constraints: BoxConstraints.tight(const Size(250, 250)),
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      // items:
                      //     alldeptState.alldeptnamelist,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          labelText: "Leave Type :",
                          hintText: "Select Applicable Leave Type",
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          // dropdownvalue2 = newValue as String;
                        });

                        // dropdownvalue22 = alldeptState.deptidwithname.keys.firstWhere((k) => alldeptState.deptidwithname[k] == dropdownvalue2, orElse: () => null);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 237, 237),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color.fromARGB(255, 225, 222, 222))),
                    child:
                        //  Row(
                        //   children: [
                        //     Text(
                        //       " Balance Credit : ",
                        //       style: TextStyle(color: Colors.grey[600]),
                        //     ),
                        //     const Text("____")
                        //   ],
                        // )
                        TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              hintText: 'Balance Credit :',
                            )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
