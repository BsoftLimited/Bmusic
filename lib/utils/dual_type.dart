class DualType<T,R>{
    T? __first;
    bool get isFirst => __first != null;
    T get first => __first!;

    R? __second;
    bool get isSecond => __second != null;
    R get second => __second!;

    DualType(this.__first, this.__second);

    factory DualType.first(T? first) => DualType(first, null);
    factory DualType.second(R? second) => DualType(null, second);
}