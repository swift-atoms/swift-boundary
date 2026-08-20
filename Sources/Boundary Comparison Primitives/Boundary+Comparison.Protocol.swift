// Boundary+Comparison.Protocol.swift
// Conformance of Boundary.Edge / Boundary.Corner to Comparison.Protocol — unconditional.
//
// The comparison witnesses live in the root. `Comparison.Protocol` aliases
// `Swift.Comparable`, so these declarations supply both conformances.

public import Boundary_Primitive
public import Comparison_Primitives

extension Boundary.Edge: Comparison.`Protocol` {}
extension Boundary.Corner: Comparison.`Protocol` {}
