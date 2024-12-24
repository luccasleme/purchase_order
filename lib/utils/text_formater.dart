String textFormater(String text) {
  if (text.contains('/')) {
    var textList = text.split('/');
    var newText = '${textList[0]}/\n${textList[1]}';
    return newText;
  }
  if (text == '- None -') {
    return 'Incomplete data';
  }
  return text;
}
