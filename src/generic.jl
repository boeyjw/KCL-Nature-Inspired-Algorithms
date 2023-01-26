function code_to_label_edges(g; with_weight=true)
    total_weight = 0
    for e = edges(g)
        println(
            label_for(g, e.src), " => ", label_for(g, e.dst), " ",
            with_weight ? join(["(", g[label_for(g, e.src), label_for(g, e.dst)], ")"]) : "", 
            "\n"
        )
        total_weight = total_weight + g[label_for(g, e.src), label_for(g, e.dst)];
    end
    if with_weight
        println("Total Weight: ", total_weight)
    end
end