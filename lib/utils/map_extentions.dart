extension MapUtils<K, V> on Map<K, V>{
    Map<K, V> sortByValue(int Function(V a, V b) compare){
        List<MapEntry<K, V>> init = entries.toList();
        init.sort((entryA, entryB){
            return compare(entryA.value, entryB.value);
        });

        return Map.fromEntries(init);
    }

    Map<K, V> sortByKey(int Function(K a, K b) compare){
        List<MapEntry<K, V>> init = entries.toList();
        init.sort((entryA, entryB){
            return compare(entryA.key, entryB.key);
        });

        return Map.fromEntries(init);
    }
}