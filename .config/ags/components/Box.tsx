interface BoxProps {
  vertical?: boolean
  spacing?: number
  className?: string
  children?: any
}

export function Box({ vertical = false, spacing = 0, className = "", children }: BoxProps) {
  return (
    <box
      vertical={vertical}
      spacing={spacing}
      cssClasses={[className]}
    >
      {children}
    </box>
  )
}
