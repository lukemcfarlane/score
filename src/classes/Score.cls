public with sharing class Score {
    List<SObject> sobjectList;

    List<Object> objResult;
    List<SObject> sobjResult;

    public Score(List<SObject> sobjectList) {
        this.sobjectList = sobjectList;
        this.sobjResult = sobjectList;
    }

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

    public List<Object> value() {
        return this.objResult;
    }

    public static Score chain(List<SObject> sobjectList) {
        return new Score(sobjectList);
    }
}