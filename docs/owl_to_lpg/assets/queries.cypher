MATCH (n) DETACH DELETE n;

CREATE (b:Class {iri:"http://progete.stanford.edu/basf/B", node_label:"B", type:"http://www.w3.org/2002/07/owl#Class"})
CREATE (subClassOf:Axiom {type: "http://www.w3.org/2002/07/owl#subClassOf", node_label:"subClassOf"})
CREATE (annotationAssertion:Axiom {type: "http://www.w3.org/2002/07/owl#annotationAssertion", node_label:"annotationAssertion"})
CREATE (b)-[:REL]->(subClassOf)
CREATE (b)-[:REL]->(annotationAssertion)
CREATE (definition:AnnotationProperty {iri: "http://www.w3.org/2004/02/skos/core#definition", node_label:"definition"})
CREATE (annotationAssertion)-[:REL]->(definition)
CREATE (_lit:Literal {value: "foo", lang:"en"})
CREATE (definition)-[:REL]->(_lit)
CREATE (creator_1:AnnotationProperty {iri: "http://purl.org/dc/elements/1.1/creator", node_label:"creator"})
CREATE (subClassOf)-[:AXIOM_ANNOTATION]->(creator_1)
CREATE (matthew:Individual {iri:"http://progete.stanford.edu/basf/mhorridge", node_label:"mhorridge"})
CREATE (creator_1)-[:REL]->(matthew)
CREATE (opa_1:Axiom {type: "http://www.w3.org/2002/07/owl#objectPropertyAssertion", node_label:"objectPropertyAssertion"})
CREATE (matthew)-[:REL]->(opa_1)
CREATE (w_1:ObjectProperty {iri:"http://progete.stanford.edu/basf/w", node_label:"w"})
CREATE (opa_1)-[:REL]->(w_1)
CREATE (stanfordUniversity:Individual {iri:"http://progete.stanford.edu/basf/stanfordUniversity", node_label:"stanfordUniversity"})
CREATE (w_1)-[:REL]->(stanfordUniversity)
CREATE (creator_2:AnnotationProperty {iri: "http://purl.org/dc/elements/1.1/creator", node_label:"creator"})
CREATE (opa_1)-[:AXIOM_ANNOTATION]->(creator_2)
CREATE (rsgoncalves:Individual {iri:"http://progete.stanford.edu/basf/rsgoncalves", node_label:"rsgoncalves"})
CREATE (creator_2)-[:REL]->(rsgoncalves)
CREATE (opa_2:Axiom {type: "http://www.w3.org/2002/07/owl#objectPropertyAssertion", node_label:"objectPropertyAssertion"})
CREATE (rsgoncalves)-[:REL]->(opa_2)
CREATE (w_2:ObjectProperty {iri:"http://progete.stanford.edu/basf/w", node_label:"w"})
CREATE (opa_2)-[:REL]->(w_2)
CREATE (w_2)-[:REL]->(stanfordUniversity)