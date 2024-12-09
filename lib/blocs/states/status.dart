enum StateStatus { initial, loading, success, failure }

extension StateStatusX on StateStatus {
    bool get isInitial => this == StateStatus.initial;
    bool get isLoading => this == StateStatus.loading;
    bool get isSuccess => this == StateStatus.success;
    bool get isFailure => this == StateStatus.failure;

    String get serialize{
        switch(this){
            case StateStatus.failure:
                return "failure";
            case StateStatus.loading:
                return "loading";
            case StateStatus.initial:
                return "initial";
            case StateStatus.success:
                return "success";
        }
    }
}

extension StateStatusString on String {
    StateStatus get toStatus{
        switch(toLowerCase()){
            case "loading":
                return StateStatus.loading;
            case "failure":
                return StateStatus.failure;
            case "initial":
                return StateStatus.initial;
            case "success":
                return StateStatus.success;
            default:
                return StateStatus.initial;
        }
    }
}