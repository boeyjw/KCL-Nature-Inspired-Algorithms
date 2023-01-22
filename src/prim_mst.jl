function prim_mst_algo(g, initial_vertex)
    #=
    There is still something wrong
    =#
    mst = MetaGraph(Graph(), EdgeData=Int, graph_data="MST", weight_function=identity, default_weight=0);
    for v = vertices(g)
        mst[label_for(g, v)] = g[label_for(g, v)];
    end
    in_mst = [];
    seen = [code_for(g, initial_vertex)];
    
    while !issetequal(vertices(g), in_mst)
        nb = [n for n = neighbors(g, seen[end]) if !(n in seen)];
        if isempty(nb)
            throw("No solution!");
        end
        min_weight = nb[argmin([g[label_for(g, seen[end]), label_for(g, n)] for n in nb])];
        mst[label_for(g, seen[end]), label_for(g, min_weight)] = g[label_for(g, seen[end]), label_for(g, min_weight)];
        push!(in_mst, seen[end], min_weight);
        push!(seen, min_weight);
    end
    return mst, sum(weights(mst)) / 2
end

function prim_wrapper(g)
    mst = nothing;
    cost = nothing;
    for i = collect(vertices(g))
        try    
            mst, cost = prim_mst_algo(g, label_for(g, i));
        catch
            nothing;
        end
    end
    return mst, cost
end