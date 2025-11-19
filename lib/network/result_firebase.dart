sealed class ResultFB<T>{}

class SuccessFB<T> extends ResultFB<T>{
    SuccessFB({this.data});
    T? data;
  
}
class ErrorFB<T> extends ResultFB<T>{
    ErrorFB(this.error);
    String error;

}