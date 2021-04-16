
void main() {

}
  Convert(int timeneeded) {
    double hours = timeneeded / 60;
    var hour = hours.toInt();
    var minutes = timeneeded % 60;


    return('$hour:$minutes');

  }


