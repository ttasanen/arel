module ActiveRelation
  class Selection < Compound
    attr_reader :predicate

    def initialize(relation, *predicates)
      @predicate = predicates.shift
      @relation = predicates.empty?? relation : Selection.new(relation, *predicates)
    end

    def ==(other)
      self.class == other.class and
      relation   == other.relation and
      predicate  == other.predicate
    end

    def qualify
      Selection.new(relation.qualify, predicate.qualify)
    end

    protected
    def selects
      relation.send(:selects) + [predicate]
    end
  end
end