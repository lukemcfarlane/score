public with sharing class Score {
    List<SObject> sobjectList;

    List<Object> objResult;
    List<SObject> sobjResult;

    public Score(List<SObject> sobjectList) {
        this.sobjectList = sobjectList;
        this.sobjResult = sobjectList;
    }


    /********* PLUCK *********/
    public static List<Object> pluck(List<SObject> sobjectList, String fieldName) {
        List<Object> vals = new List<Object>();
        for(SObject s : sobjectList) {
            vals.add(s.get(fieldName));
        }
        return vals;
    }

    public Score pluck(String fieldName) {
        this.objResult = Score.pluck(this.sobjResult, fieldName);
        return this;
    }


    /********* FIRST *********/
    public static List<Object> first(List<Object> objectList) {
        if(objectList.size() > 0) {
            return new List<Object> { objectList[0] } ;
        } else {
            return new List<Object>();
        }
    }

    public Score first() {
        this.objResult = Score.first(this.objResult);
        return this;
    }


    /********* MAP; alias COLLECT *********/
    /* Note that as map is a reserved word in Apex, the map function is called doMap */
    /* Note that you will always get back a List<Object>, which cannot be down cast, as in Java. You would generally
        loop over the list, casting each list object to the appropriate type */
    public interface MapFunction {
        Object run(Object arg);
    }

    public static List<Object> doMap(List<Object> objectList, MapFunction theFunction) {
        List<Object> returnList = new List<Object>();
        for(Object currObject : objectList){
            returnList.add(theFunction.run(currObject));
        }
        return returnList;
    }

    public Score doMap(MapFunction theFunction) {
        this.objResult = Score.doMap(this.objResult, theFunction);
        return this;
    }

    public static List<Object> collect(List<Object> objectList, MapFunction theFunction) {
        return Score.doMap(objectList, theFunction);
    }

    public Score collect(MapFunction theFunction) {
        return this.doMap(theFunction);
    }


    /********* CHAINING *********/
    public static Score chain(List<SObject> sobjectList) {
        return new Score(sobjectList);
    }

    public List<Object> value() {
        return this.objResult;
    }

}