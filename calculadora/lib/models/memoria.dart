class Memoria {
  static const operations = ['%', '/', 'x', '-', '+', '='];

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String? _operation;
  String _value = '0';
  bool _wipeValue = false;
  String _lastCommand = '';

  void applyCommand(String command){
    if (_isReplacingOperation(command)){
      _operation = command;
      return;
    }
    if(command == 'C'){
      _allclear();
    } else if (command == '<-') {
    _deleteLastDigit();

    } else if(operations.contains(command)){
      _setOperation(command);
    } else{
    _addDigit(command);
  }

  _lastCommand = command;
}
    //verificar se o usuario trocou de operação
    _isReplacingOperation(String command){
    return operations.contains(_lastCommand)
    && operations.contains(command)
    && _lastCommand != '='
    && command != '=';
  }

  //definição da operação e o calculo
  _setOperation(String newOperation){
    bool isEqualSign = newOperation == '=';
    if(_bufferIndex == 0){
      _operation = newOperation;
      _bufferIndex = 1;
      _wipeValue = true;
    } else{
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;
      
      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }

      _wipeValue = true; 
  }

   //adiciona um novo dígito ou ponto decimal ao número atual
  _addDigit(String digit){

    final isDot = digit == '.';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if(isDot && _value.contains('.') && !wipeValue){
      return;
    }
    
    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  //apagar tudo
  _allclear(){
    _value = '0';
    _buffer.setAll(0, [0.0,0.0]);
    _bufferIndex = 0;
    _operation = null;
    _wipeValue = false;
  }

  //apagar o ultimo numero digitado
  void _deleteLastDigit() {
  if (_wipeValue || _value.length <= 1) {
    _value = '0';
  } else {
    _value = _value.substring(0, _value.length - 1);
  }

  _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
}

  //Realizar calculo conforme operação
  _calculate(){
    switch(_operation){
      case '%': return _buffer[0] * _buffer[1] / 100;
      case '/': return _buffer[0] / _buffer[1];
      case 'x': return _buffer[0] * _buffer[1];
      case '-': return _buffer[0] - _buffer[1];
      case '+': return _buffer[0] + _buffer[1];
      default: return _buffer[0];
    }
  }

  String get value{
    return _value;
  }
}