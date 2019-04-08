# High level model construction

function xpress_model(;    # solver environment
    name::String="",               # model name
    sense::Symbol=:minimize,       # :minimize or :maximize
    H::CoeffMat=emptyfmat,         # quadratic coefficient matrix
    f::FVec=emptyfvec,             # linear coefficient vector
    A::CoeffMat=emptyfmat,         # LHS of inequality constraints
    b::FVec=emptyfvec,             # RHS of inequality constraints
    Aeq::CoeffMat=emptyfmat,       # LHS of equality constraints
    beq::FVec=emptyfvec,           # RHS of equality constraints
    lb::Union{Real,Vector}=-Inf,               # upper bounds
    ub::Union{Real,Vector}=Inf)                # lower bounds

    # check f
    if isempty(f)
        error("f must be specified.")
    end

    # create model
    model = Model(name)

    # set sense
    if sense != :minimize
        set_sense!(model, sense)
    end

    # add variables
    add_cvars!(model, f, lb, ub)
    #update_model!(model)

    # add qpterms
    if !isempty(H)
        add_qpterms!(model, H)
    end

    # add constraints
    if !isempty(A) && !isempty(b)
        add_constrs!(model, A, XPRS_LEQ, b)
    end

    if !isempty(Aeq) && !isempty(beq)
        add_constrs!(model, Aeq, XPRS_EQ, beq)
    end
    #update_model!(model)

    return model
end
