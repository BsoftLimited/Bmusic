enum ViewState{
    idle, busy, emty, error, unAuthorized
}

enum ErrorType{
    defaultError, networkError
}

class ViewStateError{
    ErrorType errorType;
    late String message;
    String errorMessage;

    bool get isNetworkError => errorType == ErrorType.networkError;

    ViewStateError({ this.errorType = ErrorType.defaultError, String? message, required this.errorMessage }){
        this.message = message ?? errorMessage;
    }

    @override
    String toString() {
        return "WidgetStateError{ErrorType: $errorType, message: $message, errorMessage: $errorMessage }";
    }
}