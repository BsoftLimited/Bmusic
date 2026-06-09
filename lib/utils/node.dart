class Node<T>{
    Node<T>? __left, __right;
    T value;

    Node get left => __left!;
    Node get right => __right!; 

    bool get hasLeft => __left != null;
    bool get hasRight => __right != null;

    bool Function(T current, T value) compare; 

    Node({required this.value, required this.compare});

    void add(T value){
      if(compare(this.value, value)){
        if(hasLeft){
          __left!.add(value);
        }else{
          __left = Node<T>(value: value, compare: compare);
        }
      }else{
        if(hasRight){
          __right!.add(value);
        }else{
          __right = Node<T>(value: value, compare: compare);
        }
      }
    }

    List<T> toList(){
        List<T> init = [];
        if(hasLeft){ init.addAll(__left!.toList()); }
        init.add(value);
        if(hasRight){ init.addAll(__right!.toList()); }
        return init;
    }
}