# Tranformation of OWL 2 EL ontologies to LPG graphs

---

# Introduction

This section applies the [draft model transformation][ref_draft_model] to translate OWL 2 EL axioms to a Labeled Property Graph (LPG) representation into specific use cases.
Our goal is to look for inconsistencies or missing information in the current OWL to LPG transformation

!> Take into account this is **work in progress**, no final decisions are considered here, there fore, the document is **subject to change** without notice.

# Complex OWL to LPG transformations

The validation of the OWL to LPG model (see [draft model][ref_draft_model]) is performed through several ontologies as use cases: [People Ontology][ref_people_ontology], [Cell Ontology][ref_cell_ontology]. Henceforth, the shape and color schema that is the following:


```mermaid
graph LR
    R(["Resource"]):::cNode --- AX("Axiom"):::aNode;
    R --- CE("ClassExpression"):::ceNode;
    CE --- C["Class"]:::cNode --- op["drives:ObjectProperty"]:::pNode;
    C --- dt{{"DataProperty"}}:::pNode;
    C --- at>"AnnotationProperty"]:::pNode;

```

> We previously suppose that every node stores certain basic information as: `node-label` or `iri` properties.

## Use case: People Ontology

The [People Ontology][ref_people_ontology] is used in this section for validating and reproducing some axioms from the draft model.

?> **FYI**: The default namespace for the following use cases depends on the ontology use case. For succinctness, the namespace is shortened to `:`. For example `http://owl.man.ac.uk/2006/07/sssw/people#adult` becomes `:adult`.

### Driver class

In this example we apply the [Axiom 4](https://protege.stanford.edu/owl-to-lpg/#equivalent-intersection-axioms) to represent the class `:Driver`, which is a `:Person` that `:drives` any `:Vehicle`.

```Class expression
equivalent_to(person and (drives some vehicle))
```

|**Model** |
|-------------|
|**EquivalentClasses**( :Driver **ObjectIntersectionOf**(:Person **ObjectSomeValuesFrom**(:drives :Vehicle)))| 

```mermaid
graph TB
	%% Axiom to represent: EquivalentClasses( :A ObjectIntersectionOf(:C ObjectSomeValuesFrom(:p :B)))

    A["Driver:Class"]:::cNode --> AX1(equivalentClass:Axiom):::aNode --> CE1("intersectionOf:ClassExpression"):::ceNode;
    CE1 --> C["Person:Class"]:::cNode;
    CE1 --> CE2("someValuesFrom:ClassExpression"):::ceNode;
    CE2 --> p["drives:ObjectProperty"]:::pNode;
    p --> B["Vehicle:Class"]:::cNode
```

### Mad cow class

The class `:Mad_cow` is denoted as equivalent class of the  following class expression:

```Class expression
equivalent_to(cow and (eats some (brain and (part_of some sheep))))
```
The previous expression can be transformed into an LPG model by using [Axiom 4](https://protege.stanford.edu/owl-to-lpg/#equivalent-intersection-axioms) and `ObjectIntersectionOf` class restrictions.

|**Model** |
|-------------|
|**EquivalentClasses**( :Mad_cow **ObjectIntersectionOf**(:Cow **ObjectSomeValuesFrom**(:eats **ObjectIntersectionOf**(:Brain **ObjectSomeValuesFrom**(:part_of :Sheep)))))| 

```mermaid
graph TB
	%% Axiom to represent: EquivalentClasses( :Mad_cow 
	%%	ObjectIntersectionOf(:Cow ObjectSomeValuesFrom(:eats ObjectIntersectionOf(:Brain ObjectSomeValuesFrom(:part_of :Sheep)))))

    MAD_COW["Mad_cow:Class"]:::cNode --> EQ1(equivalentClass:Axiom):::aNode --> AND1("intersectionOf:ClassExpression"):::ceNode;
    AND1 --> COW["Cow:Class"]:::cNode;
    AND1 --> SOME1("someValuesFrom:ClassExpression"):::ceNode;
    SOME1 --> EATS["eats:ObjectProperty"]:::pNode;
    EATS --> AND2("intersectionOf:ClassExpression"):::ceNode;
    AND2 --> BRAIN["Brain:Class"]:::cNode;
    AND2 --> SOME2("someValuesFrom:ClassExpression"):::ceNode;
    SOME2 --> PART_OF["part_of:ObjectProperty"]:::pNode;
    PART_OF --> SHEEP["Sheep:Class"]:::cNode
```

<!-- EquivalentClasses(<http://owl.man.ac.uk/2006/07/sssw/people#vegetarian> ObjectIntersectionOf(<http://owl.man.ac.uk/2006/07/sssw/people#animal> ObjectAllValuesFrom(<http://owl.man.ac.uk/2006/07/sssw/people#eats> ObjectComplementOf(<http://owl.man.ac.uk/2006/07/sssw/people#animal>)) ObjectAllValuesFrom(<http://owl.man.ac.uk/2006/07/sssw/people#eats> ObjectComplementOf(ObjectSomeValuesFrom(<http://owl.man.ac.uk/2006/07/sssw/people#part_of> <http://owl.man.ac.uk/2006/07/sssw/people#animal>)))) ) -->

## Use case: Cell Ontology

Here we provide examples of OWL to LPG using the [Cell Ontology][ref_cell_ontology] as use case.

### <img src="https://icongram.jgog.in/material/alert-octagram.svg?color=fff176&amp;size=16"> SubclassOf Axiom with restrictions and EquivalentTo anonymous class 

A `:Abnormal_cell` (http://purl.obolibrary.org/obo/CL_0001061) is a subclass of the anonymous class `'bearer of' some abnormal`. Additionally, it is equivalent to two additional classes: `:Cell` (http://purl.obolibrary.org/obo/CL_0000000) and `'bearer of' some abnormal`. The class expression is the following:

```Class expression
subclass_of('bearer of' some abnormal)
equivalent_to(cell and ('bearer of' some abnormal))
```
This example states the [Axiom 3](https://protege.stanford.edu/owl-to-lpg/#subclassof-somevaluesfrom-axioms). Take into account that this axiom is also reproducible for its variations. For instance: using `AllValuesFrom` axiom restriction instead of a `SomeValuesFrom` axiom.

|**Model** |
|-------------|
|**SubClassOf**( :Cell **ObjectSomeValuesFrom**( :'bearer of' :cell ) )|
|**EquivalentClasses**(:Abnormal_cell **ObjectIntersectionOf** ( :Cell **ObjectSomeValuesFrom** (:'bearer of' :abnormal)))|


```mermaid
graph TB
	%% EquivalentClasses(<http://purl.obolibrary.org/obo/CL_0001061> ObjectIntersectionOf(<http://purl.obolibrary.org/obo/GO_0005623> ObjectSomeValuesFrom(<http://purl.obolibrary.org/obo/RO_0000053> <http://purl.obolibrary.org/obo/PATO_0000460>)) )
	%% SubClassOf(<http://purl.obolibrary.org/obo/CL_0001061> ObjectSomeValuesFrom(<http://purl.obolibrary.org/obo/RO_0000053> <http://purl.obolibrary.org/obo/PATO_0000460>))

    ABNORMAL_CELL["Abnormal_cell:Class"]:::cNode --> SUBCLASS_OF("subClassOf:Axiom"):::aNode;
    SUBCLASS_OF --> SOME("someValuesFrom:ClassExpression"):::ceNode;
    SOME --> BEARER_OF["'bearer of':ObjectProperty"]:::pNode;
    BEARER_OF --> ABNORMAL["Abnormal:Class"]:::cNode

    ABNORMAL_CELL --> EQ1(equivalentClass:Axiom):::aNode --> AND1("intersectionOf:ClassExpression"):::ceNode;
    AND1 --> CELL["Cell:Class"]:::cNode;
    AND1 --> SOME1("someValuesFrom:ClassExpression"):::ceNode;
    SOME1 --> BEARER_OF;
    BEARER_OF --> ABNORMAL;
```

!> **Important**:  Double edged linkage between `bearer of:ObjectProperty` and `Abnormal:calss`.

### Annotation Axioms with Language-Tagged-Literal objects

In this example we apply the [Axiom 13](https://protege.stanford.edu/owl-to-lpg/#annotation-assertion-object-axioms), [Axiom 14](https://protege.stanford.edu/owl-to-lpg/#annotation-assertion-literal-axioms) and [Axiom 15](https://protege.stanford.edu/owl-to-lpg/#axiom-annotation-axioms) to represent that the class `:Life_cycle` (`iri: http://purl.obolibrary.org/obo/UBERON_0000104`) has a definition of type `xsd:string`.


|**Model** |
|-------------|
|**AnnotationAssertion**( :definition :Life_cycle "An entire span of an..."^^xsd:string )|
|**AnnotationAssertion**( :label :definition "definition"^^xsd:string@en )|

```mermaid
graph TB

	LIFE_CYCLE["Life_cycle:Class"]:::cNode --> AX1("annotationAssertion:Axiom"):::aNode;
	AX1 --> DEFINITION>"definition:AnnotationProperty"]:::pNode;
	DEFINITION --> LITERAL1(["_lit1:Literal<br/> <br/>'value'='An ...'"]):::cNode;
	LITERAL1 --> STRING_DT(["string:Datatype"]):::cNode;

	DEFINITION --> AX2("annotationAssertion:Axiom"):::aNode;
	AX2 --> LABEL1>"label:AnnotationProperty"]:::pNode;
	LABEL1 --> LITERAL2(["_lit2:Literal<br/> <br/>'value'='definition'<br/>'lang'='en'"]):::cNode;
	LITERAL2 --> STRING_DT(["string:Datatype"]):::cNode;
```

### Database cross references

In this case, we use the [previous Section](#annotation-axioms-with-language-tagged-literal-objects). However, this use case will address the problem of linking an `Annotation` to a http://www.geneontology.org/formats/oboInOwl#hasDbXref.

|**Model** |
|-------------|
|**AnnotationAssertion**( :definition :Life_cycle "An entire span of an..."^^xsd:string )|
|**AnnotationAssertion**( :label :definition "definition"^^xsd:string@en )|
|**AnnotationAssertion**( :hasDbXref :definition "https://...")|

```mermaid
graph TB

	LIFE_CYCLE["Life_cycle:Class"]:::cNode --> AX1("annotationAssertion:Axiom"):::aNode;
	AX1 --> DEFINITION>"definition:AnnotationProperty"]:::pNode;
	DEFINITION --> LITERAL1(["_lit1:Literal<br/> <br/>'value'='An ...'"]):::cNode;
	LITERAL1 --> STRING_DT(["string:Datatype"]):::cNode;

	DEFINITION --> AX2("annotationAssertion:Axiom"):::aNode;
	AX2 --> LABEL1>"label:AnnotationProperty"]:::pNode;
	LABEL1 --> LITERAL2(["_lit2:Literal<br/> <br/>'value'='definition'<br/>'lang'='en'"]):::cNode;
	LITERAL2 --> STRING_DT(["string:Datatype"]):::cNode;

	DEFINITION --> AX3("annotationAssertion:Axiom"):::aNode;
	AX3 --> XREF>"hasDbXref:AnnotationProperty"]:::pNode;
	XREF --> LITERAL3(["_lit3:Literal<br/> <br/>'value'='http://...'"]):::cNode;
```

<!-- Reusable references -->

[ref_draft_model]: https://protege.stanford.edu/owl-to-lpg/#transformation
[ref_people_ontology]: http://owl.man.ac.uk/2006/07/sssw/people.owl
[ref_cell_ontology]: https://bioportal.bioontology.org/ontologies/CL
