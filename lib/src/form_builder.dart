import 'package:flutter/material.dart';

typedef ValueTransformer<T> = dynamic Function(T value);

class FormBuilder extends StatefulWidget {
  //final BuildContext context;
  final Function(Map<Object, dynamic>) onChanged;
  final WillPopCallback onWillPop;
  final Widget child;
  final bool readOnly;
  final bool autovalidate;
  final Map<Object, dynamic> initialValue;

  const FormBuilder({
    Key key,
    @required this.child,
    this.readOnly = false,
    this.onChanged,
    this.autovalidate = false,
    this.onWillPop,
    this.initialValue = const {},
  }) : super(key: key);

  static FormBuilderState of(BuildContext context) =>
      context.findAncestorStateOfType<FormBuilderState>();

  @override
  FormBuilderState createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  //TODO: Find way to assert no duplicates in field attributes
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<Object, GlobalKey<FormFieldState>> _fieldKeys;

  Map<Object, dynamic> _value;

  Map<Object, dynamic> get value => {...widget.initialValue ?? {}, ..._value};

  Map<Object, dynamic> get initialValue => widget.initialValue;

  Map<Object, GlobalKey<FormFieldState>> get fields => _fieldKeys;

  bool get readOnly => widget.readOnly;

  @override
  void initState() {
    super.initState();
    _fieldKeys = {};
    _value = {};
  }

  @override
  void dispose() {
    _fieldKeys = null;
    super.dispose();
  }

  void updateFormAttributeValue(Object attribute, dynamic value) {
    setState(() {
      _value = {..._value, attribute: value};
    });
  }

  registerFieldKey(Object attribute, GlobalKey<FormFieldState> key) {
    // assert(_fieldKeys.containsKey(attribute) == false, "Field with attribute '$attribute' already exists. Make sure that two or more fields don't have the same attribute name.");
    this._fieldKeys[attribute] = key;
  }

  unregisterFieldKey(Object attribute) {
    this._fieldKeys.remove(attribute);
  }

  /*changeAttributeValue(Object attribute, dynamic newValue) {
    print(this.fieldKeys[attribute]);
    if (this.fieldKeys[attribute] != null){
      print("Current $attribute value: ${this.fieldKeys[attribute].currentState.value}");
      print("Trying to change $attribute to $newValue");
      this.fieldKeys[attribute].currentState.didChange(newValue);
      print("$attribute value after: ${this.fieldKeys[attribute].currentState.value}");
    }
  }*/

  void save() {
    _formKey.currentState.save();
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  bool saveAndValidate() {
    _formKey.currentState.save();
    return _formKey.currentState.validate();
  }

  void reset() {
    _formKey.currentState.reset();
    /*_fieldKeys.forEach((mapKey, fieldKey) {
      // print("Reseting $mapKey");
      fieldKey.currentState.reset();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: widget.child,
      autovalidate: widget.autovalidate,
      onWillPop: widget.onWillPop,
      onChanged: () {
        if (widget.onChanged != null) {
          save();
          widget.onChanged(value);
        }
      },
    );
  }
}
