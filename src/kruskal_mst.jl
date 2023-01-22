function kruskal_mst(g)
    wm = sort([(g[label_for(g, e.src), label_for(g, e.dst)], e.src, e.dst) for e in edges(g)]);
    mst = MetaGraph(Graph(), EdgeData=Int, graph_data="MST", weight_function=identity, default_weight=0);
    for v in vertices(g)
        mst[label_for(g, v)] = g[label_for(g, v)];
    end
    
    for (w, src, dst) = wm
        if ne(mst) == nv(mst)-1
            break
        end
        src_lb = label_for(g, src);
        dst_lb = label_for(g, dst);
        mst[src_lb, dst_lb] = g[src_lb, dst_lb];
        if is_cyclic(mst)
            rem_edge!(mst, src, dst);
        end
    end
    return mst, sum(weights(mst)) / 2
end