function prim_mst_algo(g, initial_vertex)
    w = collect(weights(g));
    S = [code_for(g, initial_vertex)];
    mst = MetaGraph(Graph(), EdgeData=Int, graph_data="MST", weight_function=identity, default_weight=-1);
    mst[init_V] = nothing;

    while !issetequal(collect(vertices(g)), collect(vertices(mst)))
        min_weight = nothing;
        min_code = nothing;
        for nb in collect(neighbors(g, S[end]))
            if nb in S
                continue
            end
            if min_weight == nothing || min_weight > w[S[end], nb]
                min_weight = w[S[end], nb];
                min_code = nb;
            end
        end
        mst[label_for(g, min_code)] = nothing;
        mst[label_for(g, S[end]), label_for(g, min_code)] = min_weight;
        push!(S, min_code);
    end
    return mst
end

function prim_wrapper(g)
    best = nothing;
    for v in collect(vertices(g))
        if !(best === nothing)
            break
        end
        try
            best = prim_mst_algo(g, v);
        catch
            nothing;
        end
    end
    return [label_for(best, v) for v in collect(vertices(best))]
end