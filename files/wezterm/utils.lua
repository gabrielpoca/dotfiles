_G["object_assign"] = function(t1, t2)
  for key, value in pairs(t2) do
    t1[key] = value
  end

  return t1
end
